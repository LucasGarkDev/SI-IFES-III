/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.ClienteService;
import jakarta.validation.Valid;
import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/clientes")
public class ClienteController {

    private final ClienteService service;

    public ClienteController(ClienteService service) { this.service = service; }

    @PostMapping("/socio")
    public ResponseEntity<ClienteDTO> criarSocio(@Valid @RequestBody SocioCreateDTO dto) {
        return ResponseEntity.ok(service.criarSocio(dto));
    }

    @GetMapping
    public ResponseEntity<Page<ClienteDTO>> listar(
            @PageableDefault(size = 10, sort = "nome") Pageable pageable,
            @RequestParam(required = false) String nome,
            @RequestParam(required = false) Boolean ativo,
            @RequestParam(required = false) String tipo
    ) {
        ClienteFiltro f = new ClienteFiltro();
        f.setNome(nome);
        f.setEstaAtivo(ativo);
        f.setTipoCliente(tipo);
        return ResponseEntity.ok(service.listar(f, pageable));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}

