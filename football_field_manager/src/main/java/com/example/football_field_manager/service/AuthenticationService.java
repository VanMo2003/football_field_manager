package com.example.football_field_manager.service;


import com.example.football_field_manager.constant.PredefinedRole;
import com.example.football_field_manager.dto.request.AuthenticationRequest;
import com.example.football_field_manager.dto.request.IntrospectRequest;
import com.example.football_field_manager.dto.response.AuthenticationResponse;
import com.example.football_field_manager.dto.response.IntrospectResponse;
import com.example.football_field_manager.entity.Role;
import com.example.football_field_manager.entity.User;
import com.example.football_field_manager.exception.AppException;
import com.example.football_field_manager.exception.ErrorCode;
import com.example.football_field_manager.repository.UserRepository;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.CannotCreateTransactionException;

import java.text.ParseException;
import java.util.Date;
import java.util.Objects;
import java.util.StringJoiner;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class AuthenticationService {
    PasswordEncoder passwordEncoder;
    @NonFinal
    @Value("${jwt.signer-key}")
    protected String SIGNER_KEY;

    @NonFinal
    @Value("${jwt.access-token-expiration}")
    long ACCESS_TOKEN_TIME_EXPIRATION;
    UserRepository userRepository;

    public IntrospectResponse introspect(IntrospectRequest request) throws JOSEException, ParseException {
        var token = request.getToken();

        JWSVerifier jwsVerifier = new MACVerifier(SIGNER_KEY.getBytes());

        SignedJWT signedJWT = SignedJWT.parse(token);

        var expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();

        var verified = signedJWT.verify(jwsVerifier);

        return IntrospectResponse.builder()
                .valid(verified && expiryTime.after(new Date()))
                .build();
    }

    public AuthenticationResponse authentication(AuthenticationRequest request) {
        try {
            User user = userRepository.findByUsername(request.getUsername()).orElseThrow(() -> {
                throw new AppException(ErrorCode.INCORRECT_ACCOUNT_OR_PASSWORD);
            });

            boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());
            if (!authenticated){
                throw new AppException(ErrorCode.INCORRECT_ACCOUNT_OR_PASSWORD);
            }

            String token = generateToken(user);

            return AuthenticationResponse.builder()
                    .authenticated(true)
                    .token(token)
                    .build();
        }catch (DataAccessException | CannotCreateTransactionException e){
            throw new AppException(ErrorCode.CANNOT_CONNECT_TO_SERVER);
        }
    }

    public String generateToken(User user) {
        JWSHeader jwsHeader = new JWSHeader(JWSAlgorithm.HS512);

        Date creationTime = new Date();
        Date expiryTime = new Date(creationTime.getTime() + ACCESS_TOKEN_TIME_EXPIRATION * 1000);

        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(user.getUsername())
                .claim("scope", buildScope(user.getRole()))
                .issuer("vanmo.com")
                .issueTime(creationTime)
                .expirationTime(expiryTime)
                .build();

        Payload payload = new Payload(jwtClaimsSet.toJSONObject());

        JWSObject jwsObject = new JWSObject(jwsHeader, payload);

        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));

            return jwsObject.serialize();
        } catch (JOSEException e) {
            log.error("Cannot create token", e);
            throw new RuntimeException(e);
        }
    }

    private String buildScope(Role role){
        if (!Objects.isNull(role))
            return role.getName();
        return "";
    }
}
