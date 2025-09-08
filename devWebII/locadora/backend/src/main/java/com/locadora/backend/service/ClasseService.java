package com.locadora.backend.service;

import com.locadora.backend.domain.Classe;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.ClasseRepository;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

@Service
public class ClasseService {

    private final ClasseRepository repo;
    public ClasseService(ClasseRepository repo) { this.repo = repo; }

    @Transactional
    public ClasseDTO criar(ClasseCreateDTO dto) {
        if (repo.existsByNomeIgnoreCase(dto.getNome().trim()))
            throw new BusinessException("Já existe classe com este nome.");
        Classe c = new Classe();
        c.setNome(dto.getNome().trim());
        c.setDescricao(dto.getDescricao());
        c.setPrazoDevolucaoDias(dto.getPrazoDevolucaoDias());
        c.setPrecoDiariaCentavos(dto.getPrecoDiariaCentavos());
        c.setAtivo(true);
        return toDTO(repo.save(c));
    }

    @Transactional(readOnly = true)
    public ClasseDTO buscarPorId(Long id) {
        Classe c = repo.findById(id).orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        return toDTO(c);
    }

    @Transactional(readOnly = true)
    public Page<ClasseDTO> listar(ClasseFiltro filtro, Pageable pageable) {
        Page<Classe> page;
        if (filtro != null && StringUtils.hasText(filtro.getNome())) {
            page = repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable);
        } else {
            page = repo.findAll(pageable);
        }

        List<ClasseDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .filter(dto -> {
                    if (filtro == null) return true;
                    if (filtro.getAtivo() != null && !filtro.getAtivo().equals(dto.getAtivo())) return false;
                    return true;
                })
                .toList();

        // total ajustado ao filtro aplicado em memória
        return new PageImpl<>(content, pageable, content.size());
    }


    @Transactional
    public ClasseDTO atualizar(Long id, ClasseUpdateDTO dto) {
        Classe c = repo.findById(id).orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        if (!c.getNome().equalsIgnoreCase(dto.getNome().trim()) &&
            repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessException("Já existe classe com este nome.");
        }
        c.setNome(dto.getNome().trim());
        c.setDescricao(dto.getDescricao());
        c.setPrazoDevolucaoDias(dto.getPrazoDevolucaoDias());
        c.setPrecoDiariaCentavos(dto.getPrecoDiariaCentavos());
        if (dto.getAtivo() != null) c.setAtivo(dto.getAtivo());
        return toDTO(repo.save(c));
    }

    @Transactional
    public void excluir(Long id) {
        Classe c = repo.findById(id).orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        repo.delete(c);
    }

    private ClasseDTO toDTO(Classe c) {
        ClasseDTO dto = new ClasseDTO();
        dto.setId(c.getId());
        dto.setNome(c.getNome());
        dto.setDescricao(c.getDescricao());
        dto.setPrazoDevolucaoDias(c.getPrazoDevolucaoDias());
        dto.setPrecoDiariaCentavos(c.getPrecoDiariaCentavos());
        dto.setAtivo(c.getAtivo());
        return dto;
    }
}
