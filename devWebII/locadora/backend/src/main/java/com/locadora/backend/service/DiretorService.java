package com.locadora.backend.service;

import com.locadora.backend.domain.Diretor;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.DiretorRepository;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class DiretorService {

    private final DiretorRepository repo;

    public DiretorService(DiretorRepository repo) {
        this.repo = repo;
    }

    /* ================================================================
       CRIAR NOVO DIRETOR
       - Valida duplicidade de nome
       - Define o diretor como ativo por padrão (campo fixo na entidade)
    ================================================================ */
    @Transactional
    public DiretorDTO criar(DiretorCreateDTO dto) {
        if (repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessException("Já existe diretor com este nome.");
        }

        Diretor d = new Diretor();
        d.setNome(dto.getNome().trim());
        d.setAtivo(true);

        return toDTO(repo.save(d));
    }

    /* ================================================================
       BUSCAR POR ID
       - Retorna DTO se encontrado
       - Lança NotFoundException se não existir
    ================================================================ */
    @Transactional(readOnly = true)
    public DiretorDTO buscarPorId(Long id) {
        Diretor d = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        return toDTO(d);
    }

    /* ================================================================
       LISTAR COM FILTRO E PAGINAÇÃO
       - Busca paginada e filtrada apenas por nome
    ================================================================ */
    @Transactional(readOnly = true)
    public Page<DiretorDTO> listar(DiretorFiltro filtro, Pageable pageable) {
        Page<Diretor> page;

        if (filtro != null && StringUtils.hasText(filtro.getNome())) {
            page = repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable);
        } else {
            page = repo.findAll(pageable);
        }

        List<DiretorDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .toList();

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    /* ================================================================
       ATUALIZAR DIRETOR
       - Atualiza apenas o nome
       - Valida duplicidade
    ================================================================ */
    @Transactional
    public DiretorDTO atualizar(Long id, DiretorUpdateDTO dto) {
        Diretor d = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Diretor não encontrado"));

        if (!d.getNome().equalsIgnoreCase(dto.getNome().trim())
                && repo.existsByNomeIgnoreCase(dto.getNome().trim())) {
            throw new BusinessException("Já existe diretor com este nome.");
        }

        d.setNome(dto.getNome().trim());

        return toDTO(repo.save(d));
    }

    /* ================================================================
       EXCLUIR DIRETOR
       - Verifica existência
    ================================================================ */
    @Transactional
    public void excluir(Long id) {
        Diretor d = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        repo.delete(d);
    }

    /* ================================================================
       CONVERSÃO ENTIDADE → DTO
    ================================================================ */
    private DiretorDTO toDTO(Diretor d) {
        DiretorDTO dto = new DiretorDTO();
        dto.setId(d.getId());
        dto.setNome(d.getNome());
        return dto;
    }
}

