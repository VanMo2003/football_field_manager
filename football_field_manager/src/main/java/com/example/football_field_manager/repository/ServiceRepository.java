package com.example.football_field_manager.repository;


import com.example.football_field_manager.entity.Service;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long> {
    @Query(
            nativeQuery = true,
            value =
                    """
			SELECT *\s
			FROM football_field_manager.service
			where (football_field_manager.service.name = :name)
			and football_field_manager.service.football_field_id = :footballFieldId;
		""")
    Optional<Service> findServiceFootballFieldByName(
            @Param("name") String name,
            @Param("footballFieldId") Long footballFieldId
    );
}
