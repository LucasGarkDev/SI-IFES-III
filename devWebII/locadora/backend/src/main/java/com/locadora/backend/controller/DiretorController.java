package com.locadora.backend.controller;

import com.locadora.backend.dto.*;
import com.locadora.backend.service.DiretorService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/diretores")
public class DiretorController {

    private final DiretorService service;

    public DiretorController(DiretorService service) { this.service = service; }

    @PostMapping
    public ResponseEntity<DiretorDTO> criar(@Valid @RequestBody DiretorCreateDTO dto) {
        return ResponseEntity.ok(service.criar(dto));
    }

    @GetMapping("/{id}")
    public ResponseEntity<DiretorDTO> buscar(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping
    public ResponseEntity<Page<DiretorDTO>> listar(
            @PageableDefault(size = 10, sort = "nome") Pageable pageable,
            @RequestParam(required = false) String nome,
            @RequestParam(required = false) String nacionalidade,
            @RequestParam(required = false) Boolean ativo
    ) {
        DiretorFiltro f = new DiretorFiltro();
        f.setNome(nome); f.setNacionalidade(nacionalidade); f.setAtivo(ativo);
        return ResponseEntity.ok(service.listar(f, pageable));
    }

    @PutMapping("/{id}")
    public ResponseEntity<DiretorDTO> atualizar(@PathVariable Long id,
                                                @Valid @RequestBody DiretorUpdateDTO dto) {
        return ResponseEntity.ok(service.atualizar(id, dto));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluir(@PathVariable Long id) {
        service.excluir(id);
        return ResponseEntity.noContent().build();
    }
}
