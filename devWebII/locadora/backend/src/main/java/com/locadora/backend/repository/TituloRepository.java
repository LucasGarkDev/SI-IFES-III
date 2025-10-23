/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.locadora.backend.repository;

import com.locadora.backend.domain.Titulo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TituloRepository extends JpaRepository<Titulo, Long> {
    boolean existsByNomeAndAno(String nome, Integer ano);
    Page<Titulo> findByNomeContainingIgnoreCase(String nome, Pageable pageable);
}
