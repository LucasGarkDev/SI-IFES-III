package com.locadora.backend.repository;

import com.locadora.backend.domain.Classe;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClasseRepository extends JpaRepository<Classe, Long> {
    Page<Classe> findByNomeContainingIgnoreCase(String nome, Pageable pageable);
    boolean existsByNomeIgnoreCase(String nome);
}
