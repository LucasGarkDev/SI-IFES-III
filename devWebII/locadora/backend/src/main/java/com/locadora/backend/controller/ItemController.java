/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.ItemService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/itens")
public class ItemController {

    private final ItemService service;

    public ItemController(ItemService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<ItemDTO> criar(@Valid @RequestBody ItemCreateDTO dto) {
        return ResponseEntity.ok(service.criar(dto));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ItemDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<Page<ItemDTO>> listar(
            @PageableDefault(size = 10, sort = "numSerie") Pageable pageable,
            @RequestParam(required = false) String numSerie,
            @RequestParam(required = false) String tipoItem,
            @RequestParam(required = false) String tituloNome
    ) {
        ItemFiltro f = new ItemFiltro();
        f.setNumSerie(numSerie);
        f.setTipoItem(tipoItem);
        f.setTituloNome(tituloNome);
        return ResponseEntity.ok(service.listar(f, pageable));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ItemDTO> atualizar(@PathVariable Long id, @Valid @RequestBody ItemUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
