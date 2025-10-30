/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.service;

import com.locadora.backend.domain.Item;
import com.locadora.backend.domain.Titulo;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.ItemRepository;
import com.locadora.backend.repository.TituloRepository;
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
public class ItemService {

    private final ItemRepository repo;
    private final TituloRepository tituloRepo;

    public ItemService(ItemRepository repo, TituloRepository tituloRepo) {
        this.repo = repo;
        this.tituloRepo = tituloRepo;
    }

    @Transactional
    public ItemDTO criar(ItemCreateDTO dto) {
        if (repo.existsByNumSerie(dto.getNumSerie().trim())) {
            throw new BusinessRuleException("Já existe item com este número de série.");
        }

        Titulo titulo = tituloRepo.findById(dto.getTituloId())
                .orElseThrow(() -> new NotFoundException("Título não encontrado."));

        Item i = new Item();
        i.setNumSerie(dto.getNumSerie().trim());
        i.setDtAquisicao(dto.getDtAquisicao());
        i.setTipoItem(dto.getTipoItem().trim());
        i.setTitulo(titulo);

        return toDTO(repo.save(i));
    }

    @Transactional(readOnly = true)
    public ItemDTO buscarPorId(Long id) {
        Item i = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Item não encontrado."));
        return toDTO(i);
    }

    @Transactional(readOnly = true)
    public Page<ItemDTO> listar(ItemFiltro filtro, Pageable pageable) {
        Page<Item> page;

        if (filtro != null && StringUtils.hasText(filtro.getNumSerie())) {
            page = repo.findByNumSerieContainingIgnoreCase(filtro.getNumSerie().trim(), pageable);
        } else {
            page = repo.findAll(pageable);
        }

        List<ItemDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .filter(dto -> filtro == null ||
                        (filtro.getTipoItem() == null || dto.getTipoItem().equalsIgnoreCase(filtro.getTipoItem())) &&
                        (filtro.getTituloNome() == null || dto.getTituloNome().toLowerCase().contains(filtro.getTituloNome().toLowerCase()))
                )
                .toList();

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    @Transactional
    public ItemDTO atualizar(Long id, ItemUpdateDTO dto) {
        Item i = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Item não encontrado."));

        if (!i.getNumSerie().equalsIgnoreCase(dto.getNumSerie().trim())
                && repo.existsByNumSerie(dto.getNumSerie().trim())) {
            throw new BusinessRuleException("Já existe item com este número de série.");
        }

        Titulo titulo = tituloRepo.findById(dto.getTituloId())
                .orElseThrow(() -> new NotFoundException("Título não encontrado."));

        i.setNumSerie(dto.getNumSerie().trim());
        i.setDtAquisicao(dto.getDtAquisicao());
        i.setTipoItem(dto.getTipoItem().trim());
        i.setTitulo(titulo);

        return toDTO(repo.save(i));
    }

    @Transactional
    public void excluir(Long id) {
        Item i = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Item não encontrado."));

        // Aqui será feita a verificação de locações futuramente
        // if (locacaoRepo.existsByItemId(id)) throw new BusinessRuleException("Item possui locações ativas.");

        try {
            repo.delete(i);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegrityException("Não é possível excluir o item, pois ele está vinculado a uma ou mais locações.");
        }
    }

    private ItemDTO toDTO(Item i) {
        ItemDTO dto = new ItemDTO();
        dto.setId(i.getId());
        dto.setNumSerie(i.getNumSerie());
        dto.setDtAquisicao(i.getDtAquisicao());
        dto.setTipoItem(i.getTipoItem());
        dto.setTituloId(i.getTitulo().getId());
        dto.setTituloNome(i.getTitulo().getNome());
        return dto;
    }
}

