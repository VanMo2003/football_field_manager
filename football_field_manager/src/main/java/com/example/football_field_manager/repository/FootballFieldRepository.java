package com.example.football_field_manager.repository;


import com.example.football_field_manager.entity.FootballField;
import com.example.football_field_manager.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FootballFieldRepository extends JpaRepository<FootballField, Long> {
    Optional<FootballField> findByName(String name);
    Optional<FootballField> findByUser(User user);
}
