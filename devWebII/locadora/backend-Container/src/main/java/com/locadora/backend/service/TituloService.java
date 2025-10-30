/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.service;

import com.locadora.backend.domain.*;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.*;
import com.locadora.backend.exception.BusinessRuleException;
import com.locadora.backend.exception.NotFoundException;
import com.locadora.backend.exception.DataIntegrityException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class TituloService {

    private final TituloRepository repo;
    private final ClasseRepository classeRepo;
    private final DiretorRepository diretorRepo;
    private final AtorRepository atorRepo;

    public TituloService(TituloRepository repo, ClasseRepository classeRepo,
                         DiretorRepository diretorRepo, AtorRepository atorRepo) {
        this.repo = repo;
        this.classeRepo = classeRepo;
        this.diretorRepo = diretorRepo;
        this.atorRepo = atorRepo;
    }

    @Transactional
    public TituloDTO criar(TituloCreateDTO dto) {
        if (repo.existsByNomeAndAno(dto.getNome().trim(), dto.getAno())) {
            throw new BusinessRuleException("Já existe título com este nome e ano.");
        }

        Classe classe = classeRepo.findById(dto.getClasseId())
                .orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        Diretor diretor = diretorRepo.findById(dto.getDiretorId())
                .orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        Set<Ator> atores = atorRepo.findAllById(dto.getAtoresIds()).stream().collect(Collectors.toSet());

        Titulo t = new Titulo();
        t.setNome(dto.getNome().trim());
        t.setAno(dto.getAno());
        t.setSinopse(dto.getSinopse());
        t.setCategoria(dto.getCategoria());
        t.setClasse(classe);
        t.setDiretor(diretor);
        t.setAtores(atores);

        return toDTO(repo.save(t));
    }

    @Transactional(readOnly = true)
    public TituloDTO buscarPorId(Long id) {
        Titulo t = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Título não encontrado."));
        return toDTO(t);
    }

    @Transactional(readOnly = true)
    public Page<TituloDTO> listar(TituloFiltro filtro, Pageable pageable) {
        Page<Titulo> page;
        if (filtro != null && StringUtils.hasText(filtro.getNome())) {
            page = repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable);
        } else {
            page = repo.findAll(pageable);
        }

        List<TituloDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .filter(dto -> filtro == null ||
                        (filtro.getCategoria() == null || dto.getCategoria().equalsIgnoreCase(filtro.getCategoria())) &&
                        (filtro.getAno() == null || dto.getAno().equals(filtro.getAno()))
                )
                .toList();

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    @Transactional
    public TituloDTO atualizar(Long id, TituloUpdateDTO dto) {
        Titulo t = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Título não encontrado."));

        if (!t.getNome().equalsIgnoreCase(dto.getNome().trim())
                && repo.existsByNomeAndAno(dto.getNome().trim(), dto.getAno())) {
            throw new BusinessRuleException("Já existe título com este nome e ano.");
        }

        Classe classe = classeRepo.findById(dto.getClasseId())
                .orElseThrow(() -> new NotFoundException("Classe não encontrada"));
        Diretor diretor = diretorRepo.findById(dto.getDiretorId())
                .orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        Set<Ator> atores = atorRepo.findAllById(dto.getAtoresIds()).stream().collect(Collectors.toSet());

        t.setNome(dto.getNome().trim());
        t.setAno(dto.getAno());
        t.setSinopse(dto.getSinopse());
        t.setCategoria(dto.getCategoria());
        t.setClasse(classe);
        t.setDiretor(diretor);
        t.setAtores(atores);

        return toDTO(repo.save(t));
    }

    @Transactional
    public void excluir(Long id) {
        Titulo t = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Título não encontrado."));

        // FUTURO: se tiver itens, bloquear exclusão
        // if (itemRepo.existsByTituloId(id)) throw new BusinessRuleException("Título possui itens cadastrados.");

        try {
            repo.delete(t);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegrityException("Não é possível excluir o título, pois ele está vinculado a um ou mais itens.");
        }
    }

    private TituloDTO toDTO(Titulo t) {
        TituloDTO dto = new TituloDTO();
        dto.setId(t.getId());
        dto.setNome(t.getNome());
        dto.setAno(t.getAno());
        dto.setSinopse(t.getSinopse());
        dto.setCategoria(t.getCategoria());
        dto.setClasseId(t.getClasse().getId());
        dto.setClasseNome(t.getClasse().getNome());
        dto.setDiretorId(t.getDiretor().getId());
        dto.setDiretorNome(t.getDiretor().getNome());
        dto.setAtoresNomes(t.getAtores().stream().map(Ator::getNome).toList());
        dto.setAtoresIds(t.getAtores().stream().map(Ator::getId).toList());
        return dto;
    }
}
