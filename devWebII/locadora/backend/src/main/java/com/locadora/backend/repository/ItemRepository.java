/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.locadora.backend.repository;

import com.locadora.backend.domain.Item;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface ItemRepository extends JpaRepository<Item, Long> {

    boolean existsByNumSerie(String numSerie);

    Page<Item> findByNumSerieContainingIgnoreCase(String numSerie, Pageable pageable);

    Optional<Item> findByNumSerie(String numSerie); // ✅ adicionado
    
    // NOVO: necessário para calcular quantidadeDisponivel
    int countByTituloId(Long tituloId);

    // adicional (caso queira listar itens depois)
    List<Item> findByTituloId(Long tituloId);
}


