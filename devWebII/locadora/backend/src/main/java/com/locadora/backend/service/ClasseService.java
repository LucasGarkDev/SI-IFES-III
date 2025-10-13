package com.locadora.backend.service;

import com.locadora.backend.domain.Classe;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.ClasseRepository;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class ClasseService {

    private final ClasseRepository repo;

    public ClasseService(ClasseRepository repo) {
        this.repo = repo;
    }

    /* ================================================================
       CRIAR NOVA CLASSE
       - Valida duplicidade de nome
       - Define valores e salva
    ================================================================ */
    @Transactional
    public ClasseDTO criar(ClasseCreateDTO dto) {
        if (repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessException("Já existe classe com este nome.");
        }

        Classe c = new Classe();
        c.setNome(dto.getNome().trim());
        c.setPrecoDiariaCentavos(dto.getPrecoDiariaCentavos());
        c.setDataDevolucao(dto.getDataDevolucao());

        return toDTO(repo.save(c));
    }

    /* ================================================================
       BUSCAR POR ID
       - Retorna DTO se encontrada
       - Lança NotFoundException se não existir
    ================================================================ */
    @Transactional(readOnly = true)
    public ClasseDTO buscarPorId(Long id) {
        Classe c = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        return toDTO(c);
    }

    /* ================================================================
       LISTAR COM FILTRO E PAGINAÇÃO
       - Filtro simples por nome (like)
    ================================================================ */
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
                .toList();

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    /* ================================================================
       ATUALIZAR CLASSE
       - Atualiza apenas nome, preço e data de devolução
    ================================================================ */
    @Transactional
    public ClasseDTO atualizar(Long id, ClasseUpdateDTO dto) {
        Classe c = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Classe não encontrada"));

        if (!c.getNome().equalsIgnoreCase(dto.getNome().trim())
                && repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessException("Já existe classe com este nome.");
        }

        c.setNome(dto.getNome().trim());
        c.setPrecoDiariaCentavos(dto.getPrecoDiariaCentavos());
        c.setDataDevolucao(dto.getDataDevolucao());

        return toDTO(repo.save(c));
    }

    /* ================================================================
       EXCLUIR CLASSE
       - Verifica existência antes de remover
    ================================================================ */
    @Transactional
    public void excluir(Long id) {
        Classe c = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        repo.delete(c);
    }

    /* ================================================================
       CONVERSÃO ENTIDADE → DTO
    ================================================================ */
    private ClasseDTO toDTO(Classe c) {
        ClasseDTO dto = new ClasseDTO();
        dto.setId(c.getId());
        dto.setNome(c.getNome());
        dto.setPrecoDiariaCentavos(c.getPrecoDiariaCentavos());
        dto.setDataDevolucao(c.getDataDevolucao());
        return dto;
    }
}

