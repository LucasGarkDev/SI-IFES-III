/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.locadora.backend.repository;

import com.locadora.backend.domain.Locacao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.util.Optional;

public interface LocacaoRepository extends JpaRepository<Locacao, Long> {

    @Query("SELECT CASE WHEN COUNT(l)>0 THEN true ELSE false END " +
           "FROM Locacao l WHERE l.item.id = :itemId AND l.cancelada = false AND l.dataEfetivaDevolucao IS NULL")
    boolean existsLocacaoVigente(Long itemId);

    @Query("SELECT CASE WHEN COUNT(l)>0 THEN true ELSE false END " +
           "FROM Locacao l WHERE l.cliente.id = :clienteId AND l.cancelada = false AND " +
           "l.dataEfetivaDevolucao IS NULL AND l.dataPrevistaDevolucao < :hoje")
    boolean existsLocacaoEmDebito(Long clienteId, LocalDate hoje);

    @Query("SELECT l FROM Locacao l WHERE l.item.id = :itemId AND l.cancelada = false AND l.dataEfetivaDevolucao IS NULL")
    Optional<Locacao> findLocacaoVigentePorItem(Long itemId);
}

