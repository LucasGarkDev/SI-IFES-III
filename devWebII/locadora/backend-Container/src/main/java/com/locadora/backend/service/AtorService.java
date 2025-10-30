package com.locadora.backend.service;

import com.locadora.backend.domain.Ator;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.AtorRepository;
import com.locadora.backend.exception.BusinessRuleException;
import com.locadora.backend.exception.NotFoundException;
import com.locadora.backend.exception.DataIntegrityException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class AtorService {

    private final AtorRepository repo;

    public AtorService(AtorRepository repo) {
        this.repo = repo;
    }

    /* ================================================================
       CRIAR NOVO ATOR
       - Valida duplicidade de nome
       - Define o ator como ativo por padrão (campo fixo no banco)
    ================================================================ */
    @Transactional
    public AtorDTO criar(AtorCreateDTO dto) {
        if (repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessRuleException("Já existe ator com este nome.");
        }

        Ator ator = new Ator();
        ator.setNome(dto.getNome().trim());
        ator.setAtivo(true);

        return toDTO(repo.save(ator));
    }

    /* ================================================================
       BUSCAR POR ID
       - Retorna DTO se encontrado
       - Lança NotFoundException se não existir
    ================================================================ */
    @Transactional(readOnly = true)
    public AtorDTO buscarPorId(Long id) {
        Ator ator = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Ator não encontrado"));
        return toDTO(ator);
    }

    /* ================================================================
       LISTAR COM FILTRO E PAGINAÇÃO
       - Busca paginada e filtrada apenas por nome
    ================================================================ */
    @Transactional(readOnly = true)
    public Page<AtorDTO> listar(AtorFiltro filtro, Pageable pageable) {
        Page<Ator> page;

        if (filtro != null && StringUtils.hasText(filtro.getNome())) {
            page = repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable);
        } else {
            page = repo.findAll(pageable);
        }

        List<AtorDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .toList();

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    /* ================================================================
       ATUALIZAR ATOR
       - Atualiza apenas o nome
    ================================================================ */
    @Transactional
    public AtorDTO atualizar(Long id, AtorUpdateDTO dto) {
        Ator ator = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Ator não encontrado"));

        if (!ator.getNome().equalsIgnoreCase(dto.getNome().trim())
                && repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessRuleException("Já existe ator com este nome.");
        }

        ator.setNome(dto.getNome().trim());

        return toDTO(repo.save(ator));
    }

    /* ================================================================
       EXCLUIR ATOR
       - Verifica existência
       - Trata falha de integridade referencial (ator vinculado a filme)
    ================================================================ */
    @Transactional
    public void excluir(Long id) {
        Ator ator = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Ator não encontrado"));

        try {
            repo.delete(ator);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegrityException("Não é possível excluir o ator, pois ele está vinculado a um ou mais filmes.");
        }
    }

    /* ================================================================
       CONVERSÃO ENTIDADE → DTO
    ================================================================ */
    private AtorDTO toDTO(Ator ator) {
        AtorDTO dto = new AtorDTO();
        dto.setId(ator.getId());
        dto.setNome(ator.getNome());
        return dto;
    }
}
