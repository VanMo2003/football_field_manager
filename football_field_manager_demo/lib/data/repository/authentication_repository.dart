import '../../data/models/request/authentication_request.dart';
import '../../utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class AuthenticationRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthenticationRepository({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> login(String username, String password) async {
    return await apiClient.postDataNoAuth(
      AppConstant.ENDPOINT_LOGIN,
      body: AuthenticationRequest(username: username, password: password),
    );
  }

  Future<Response> logout() async {
    return await apiClient.postDataNoAuth(AppConstant.ENDPOINT_LOGOUT);
  }

  Future<Response> introspect() async {
    return await apiClient.postDataNoAuth(AppConstant.ENDPOINT_INTROSPECT);
  }

  Future<Response> refreshToken() async {
    return await apiClient.postDataNoAuth(AppConstant.ENDPOINT_REFRESH_TOKEN);
  }

  Future<bool> saveUserToken(String? token) async {
    apiClient.token = "Bearer $token";
    apiClient.updateAuthHeader("Bearer $token");
    return await sharedPreferences.setString(
      AppConstant.TOKEN,
      "Bearer $token",
    );
  }

  Future<bool> removeToken() async {
    return await sharedPreferences.remove(AppConstant.TOKEN);
  }
}
