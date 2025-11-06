/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.LocacaoService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/locacoes")
public class LocacaoController {

    private final LocacaoService service;
    public LocacaoController(LocacaoService service) { this.service = service; }

    /* ================================================================
       EFETUAR NOVA LOCAÇÃO
    ================================================================ */
    @PostMapping
    public ResponseEntity<LocacaoDTO> criar(@Valid @RequestBody LocacaoCreateDTO dto) {
        return ResponseEntity.ok(service.criar(dto));
    }

    /* ================================================================
       EFETUAR DEVOLUÇÃO
    ================================================================ */
    @PostMapping("/devolucao")
    public ResponseEntity<LocacaoDTO> devolver(@Valid @RequestBody LocacaoDevolucaoDTO dto) {
        return ResponseEntity.ok(service.devolver(dto));
    }

    /* ================================================================
       BUSCAR LOCAÇÃO POR ID
    ================================================================ */
    @GetMapping("/{id}")
    public ResponseEntity<LocacaoDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    /* ================================================================
       LISTAR TODAS AS LOCAÇÕES
    ================================================================ */
    @GetMapping
    public ResponseEntity<List<LocacaoDTO>> listar() {
        return ResponseEntity.ok(service.listar());
    }

    /* ================================================================
       ALTERAR DADOS DE LOCAÇÃO
    ================================================================ */
    @PutMapping("/{id}")
    public ResponseEntity<LocacaoDTO> atualizar(@PathVariable Long id,
                                                @Valid @RequestBody LocacaoUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    /* ================================================================
       CANCELAR LOCAÇÃO
    ================================================================ */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> cancelar(@PathVariable Long id) {
        service.cancelar(id);
        return ResponseEntity.noContent().build();
    }
}
