package com.locadora.backend.repository;

import com.locadora.backend.domain.Ator;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;

public interface AtorRepository extends JpaRepository<Ator, Long> {
    Page<Ator> findByNomeContainingIgnoreCase(String nome, Pageable pageable);
    boolean existsByNomeAndDataNascimento(String nome, LocalDate dataNascimento);
}
