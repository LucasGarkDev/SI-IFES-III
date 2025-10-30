/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.locadora.backend.repository;

import com.locadora.backend.domain.Dependente;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DependenteRepository extends JpaRepository<Dependente, Long> {
    List<Dependente> findBySocioId(Long socioId);
    long countBySocioIdAndEstaAtivoTrue(Long socioId);
}

