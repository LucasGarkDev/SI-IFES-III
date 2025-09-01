package com.example.locadora.controller;

import com.example.locadora.domain.Ator;
import com.example.locadora.service.AtorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/atores")
@CrossOrigin(origins = "*") // permite acesso do React
public class AtorController {

    @Autowired
    private AtorService service;

    @GetMapping
    public List<Ator> listar() {
        return service.listar();
    }

    @PostMapping
    public Ator criar(@RequestBody Ator ator) {
        return service.salvar(ator);
    }

    @PutMapping("/{id}")
    public Ator atualizar(@PathVariable Long id, @RequestBody Ator atorAtualizado) {
        return service.atualizar(id, atorAtualizado.getNome());
    }

    @DeleteMapping("/{id}")
    public void deletar(@PathVariable Long id) {
        service.deletar(id);
    }

    @GetMapping("/{id}")
    public Ator buscar(@PathVariable Long id) {
        return service.buscarPorId(id).orElseThrow(() -> new RuntimeException("Ator não encontrado"));
    }
}
