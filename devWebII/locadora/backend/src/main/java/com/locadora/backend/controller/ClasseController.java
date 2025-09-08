package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.ClasseService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/classes")
public class ClasseController {

    private final ClasseService service;
    public ClasseController(ClasseService service) { this.service = service; }

    @PostMapping
    public ResponseEntity<ClasseDTO> criar(@Valid @RequestBody ClasseCreateDTO dto) {
        return ResponseEntity.ok(service.criar(dto));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClasseDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<Page<ClasseDTO>> listar(
            @PageableDefault(size = 10, sort = "nome") Pageable pageable,
            @RequestParam(required = false) String nome,
            @RequestParam(required = false) Boolean ativo
    ) {
        ClasseFiltro f = new ClasseFiltro();
        f.setNome(nome); f.setAtivo(ativo);
        return ResponseEntity.ok(service.listar(f, pageable));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ClasseDTO> atualizar(@PathVariable Long id,
                                               @Valid @RequestBody ClasseUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
