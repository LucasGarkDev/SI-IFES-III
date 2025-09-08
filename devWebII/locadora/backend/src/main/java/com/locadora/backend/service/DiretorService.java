package com.locadora.backend.service;

import com.locadora.backend.domain.Diretor;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.DiretorRepository;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class DiretorService {

    private final DiretorRepository repo;

    public DiretorService(DiretorRepository repo) { this.repo = repo; }

    @Transactional
    public DiretorDTO criar(DiretorCreateDTO dto) {
        if (dto.getDataNascimento() != null &&
            repo.existsByNomeAndDataNascimento(dto.getNome().trim(), dto.getDataNascimento())) {
            throw new BusinessException("Já existe diretor com este nome e data de nascimento.");
        }
        Diretor d = new Diretor();
        d.setNome(dto.getNome().trim());
        d.setNacionalidade(dto.getNacionalidade());
        d.setDataNascimento(dto.getDataNascimento());
        d.setAtivo(true);
        return toDTO(repo.save(d));
    }

    @Transactional(readOnly = true)
    public DiretorDTO buscarPorId(Long id) {
        Diretor d = repo.findById(id).orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        return toDTO(d);
    }

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
    public DiretorDTO atualizar(Long id, DiretorUpdateDTO dto) {
        Diretor d = repo.findById(id).orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        if (dto.getDataNascimento() != null &&
            repo.existsByNomeAndDataNascimento(dto.getNome().trim(), dto.getDataNascimento())
            && !(dto.getNome().equalsIgnoreCase(d.getNome())
                 && dto.getDataNascimento().equals(d.getDataNascimento()))) {
            throw new BusinessException("Já existe diretor com este nome e data de nascimento.");
        }
        d.setNome(dto.getNome().trim());
        d.setNacionalidade(dto.getNacionalidade());
        d.setDataNascimento(dto.getDataNascimento());
        if (dto.getAtivo() != null) d.setAtivo(dto.getAtivo());
        return toDTO(repo.save(d));
    }

    @Transactional
    public void excluir(Long id) {
        Diretor d = repo.findById(id).orElseThrow(() -> new NotFoundException("Diretor não encontrado"));
        repo.delete(d);
    }

    private DiretorDTO toDTO(Diretor d) {
        DiretorDTO dto = new DiretorDTO();
        dto.setId(d.getId());
        dto.setNome(d.getNome());
        dto.setNacionalidade(d.getNacionalidade());
        dto.setDataNascimento(d.getDataNascimento());
        dto.setAtivo(d.getAtivo());
        return dto;
    }
}
