package com.locadora.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.locadora.backend.domain.Ator;

@Repository
public interface AtorRepository extends JpaRepository<Ator, Long> {
}
