package com.locadora.backend.repository;

import com.locadora.backend.domain.Diretor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface DiretorRepository extends JpaRepository<Diretor, Long> {
    Page<Diretor> findByNomeContainingIgnoreCase(String nome, Pageable pageable);
    boolean existsByNomeIgnoreCase(String nome);
}
