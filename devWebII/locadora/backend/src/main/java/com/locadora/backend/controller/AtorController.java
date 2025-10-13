package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.AtorService;
import jakarta.validation.Valid;

import java.net.URI;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/atores")
public class AtorController {

    private final AtorService service;
    public AtorController(AtorService service) { this.service = service; }

    @PostMapping
    public ResponseEntity<AtorDTO> criar(@Valid @RequestBody AtorCreateDTO dto) {
        AtorDTO criado = service.criar(dto);
        URI location = URI.create("/api/atores/" + criado.getId());
        return ResponseEntity.created(location).body(criado);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AtorDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<Page<AtorDTO>> listar(
            @PageableDefault(size = 10, sort = "nome") Pageable pageable,
            @RequestParam(required = false) String nome,
            @RequestParam(required = false) String nacionalidade,
            @RequestParam(required = false) Boolean ativo
    ) {
        AtorFiltro filtro = new AtorFiltro();
        filtro.setNome(nome);
        return ResponseEntity.ok(service.listar(filtro, pageable));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AtorDTO> atualizar(@PathVariable Long id,
                                             @Valid @RequestBody AtorUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
