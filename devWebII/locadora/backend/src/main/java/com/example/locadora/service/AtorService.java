package com.example.locadora.service;

import com.example.locadora.domain.Ator;
import com.example.locadora.repository.AtorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AtorService {

    @Autowired
    private AtorRepository repository;

    public List<Ator> listar() {
        return repository.findAll();
    }

    public Ator salvar(Ator ator) {
        return repository.save(ator);
    }

    public Optional<Ator> buscarPorId(Long id) {
        return repository.findById(id);
    }

    public void deletar(Long id) {
        repository.deleteById(id);
    }

    public Ator atualizar(Long id, String novoNome) {
        Ator ator = repository.findById(id).orElseThrow(() -> new RuntimeException("Ator não encontrado"));
        ator.setNome(novoNome);
        return repository.save(ator);
    }
}
