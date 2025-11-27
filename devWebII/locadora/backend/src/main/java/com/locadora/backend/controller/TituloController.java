/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.TituloService;
import jakarta.validation.Valid;
import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/titulos")
public class TituloController {

    private final TituloService service;

    public TituloController(TituloService service) {
        this.service = service;
    }

    // ============================
    // CRUD ADMINISTRATIVO
    // ============================

    @PostMapping
    public ResponseEntity<TituloDTO> criar(@Valid @RequestBody TituloCreateDTO dto) {
        return ResponseEntity.ok(service.criar(dto));
    }

    @GetMapping("/{id}")
    public ResponseEntity<TituloDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<Page<TituloDTO>> listar(
            @PageableDefault(size = 10, sort = "nome") Pageable pageable,
            @RequestParam(required = false) String nome,
            @RequestParam(required = false) String categoria,
            @RequestParam(required = false) Integer ano
    ) {
        TituloFiltro f = new TituloFiltro();
        f.setNome(nome);
        f.setCategoria(categoria);
        f.setAno(ano);
        return ResponseEntity.ok(service.listar(f, pageable));
    }

    @PutMapping("/{id}")
    public ResponseEntity<TituloDTO> atualizar(@PathVariable Long id, @Valid @RequestBody TituloUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }


    // =============================
    //  NOVAS ROTAS PARA CONSULTA
    // =============================

    @GetMapping("/pesquisa")
    public ResponseEntity<Page<TituloListDTO>> pesquisarTitulos(
            @RequestParam(defaultValue = "") String nome,
            @PageableDefault(size = 20, sort = "nome") Pageable pageable
    ) {
        return ResponseEntity.ok(service.pesquisarPorNome(nome, pageable));
    }

    @GetMapping("/{id}/detalhes")
    public ResponseEntity<TituloDetalhesDTO> obterDetalhes(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarDetalhes(id));
    }
}

