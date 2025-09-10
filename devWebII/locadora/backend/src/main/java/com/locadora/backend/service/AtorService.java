package com.locadora.backend.service;

import com.locadora.backend.domain.Ator;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.AtorRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class AtorService {

    private final AtorRepository repo;
    public AtorService(AtorRepository repo) { this.repo = repo; }

    @Transactional
    public AtorDTO criar(AtorCreateDTO dto) {
        if (dto.getDataNascimento() != null &&
                repo.existsByNomeAndDataNascimento(dto.getNome().trim(), dto.getDataNascimento())) {
            throw new BusinessException("Já existe ator com este nome e data de nascimento.");
        }
        Ator a = new Ator();
        a.setNome(dto.getNome().trim());
        a.setNacionalidade(dto.getNacionalidade());
        a.setDataNascimento(dto.getDataNascimento());
        a.setAtivo(true);
        return toDTO(repo.save(a));
    }

    @Transactional(readOnly = true)
    public AtorDTO buscarPorId(Long id) {
        Ator a = repo.findById(id).orElseThrow(() -> new NotFoundException("Ator não encontrado"));
        return toDTO(a);
    }

    @Transactional(readOnly = true)
    public Page<AtorDTO> listar(AtorFiltro filtro, Pageable pageable) {
        Page<Ator> page = (filtro != null && StringUtils.hasText(filtro.getNome()))
                ? repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable)
                : repo.findAll(pageable);

        List<AtorDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .filter(dto -> {
                    if (filtro == null) return true;
                    if (filtro.getAtivo() != null && !filtro.getAtivo().equals(dto.getAtivo())) return false;
                    if (StringUtils.hasText(filtro.getNacionalidade())) {
                        if (dto.getNacionalidade() == null) return false;
                        if (!dto.getNacionalidade().equalsIgnoreCase(filtro.getNacionalidade())) return false;
                    }
                    return true;
                })
                .toList();

        return new PageImpl<>(content, pageable, content.size());
    }

    @Transactional
    public AtorDTO atualizar(Long id, AtorUpdateDTO dto) {
        Ator a = repo.findById(id).orElseThrow(() -> new NotFoundException("Ator não encontrado"));
        if (dto.getDataNascimento() != null &&
                repo.existsByNomeAndDataNascimento(dto.getNome().trim(), dto.getDataNascimento())
                && !(dto.getNome().equalsIgnoreCase(a.getNome()) &&
                     dto.getDataNascimento().equals(a.getDataNascimento()))) {
            throw new BusinessException("Já existe ator com este nome e data de nascimento.");
        }
        a.setNome(dto.getNome().trim());
        a.setNacionalidade(dto.getNacionalidade());
        a.setDataNascimento(dto.getDataNascimento());
        if (dto.getAtivo() != null) a.setAtivo(dto.getAtivo());
        return toDTO(repo.save(a));
    }

    @Transactional
    public void excluir(Long id) {
        Ator a = repo.findById(id).orElseThrow(() -> new NotFoundException("Ator não encontrado"));
        repo.delete(a);
    }

    private AtorDTO toDTO(Ator a) {
        AtorDTO dto = new AtorDTO();
        dto.setId(a.getId());
        dto.setNome(a.getNome());
        dto.setNacionalidade(a.getNacionalidade());
        dto.setDataNascimento(a.getDataNascimento());
        dto.setAtivo(a.getAtivo());
        return dto;
    }
}
