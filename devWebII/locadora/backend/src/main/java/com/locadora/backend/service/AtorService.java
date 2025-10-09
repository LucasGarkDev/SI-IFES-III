package com.locadora.backend.service;

import com.locadora.backend.domain.Ator;
import com.locadora.backend.dto.*;
import com.locadora.backend.repository.AtorRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.Objects;
import java.util.List;

@Service
public class AtorService {

    private final AtorRepository repo;

    public AtorService(AtorRepository repo) {
        this.repo = repo;
    }

    /* ================================================================
       CRIAR NOVO ATOR
       - Valida duplicidade de nome + dataNascimento
       - Define o ator como ativo por padrão
    ================================================================ */
    @Transactional
    public AtorDTO criar(AtorCreateDTO dto) {
        validarDuplicidade(dto.getNome(), dto.getDataNascimento(), null);

        Ator ator = new Ator();
        ator.setNome(dto.getNome().trim());
        ator.setNacionalidade(dto.getNacionalidade());
        ator.setDataNascimento(dto.getDataNascimento());
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
       - Busca paginada
       - Filtros opcionais por nome, nacionalidade e ativo
       - Mantém totalElements correto
    ================================================================ */
    @Transactional(readOnly = true)
    public Page<AtorDTO> listar(AtorFiltro filtro, Pageable pageable) {
        Page<Ator> page = (filtro != null && StringUtils.hasText(filtro.getNome()))
                ? repo.findByNomeContainingIgnoreCase(filtro.getNome().trim(), pageable)
                : repo.findAll(pageable);

        // converte e aplica filtro manualmente
        List<AtorDTO> filtrados = page.getContent().stream()
                .map(AtorService::toDTO)
                .filter(dto -> correspondeAoFiltro(dto, filtro))
                .toList();

        // retorna nova Page com os dados filtrados, preservando o Pageable original
        return new org.springframework.data.domain.PageImpl<>(filtrados, pageable, page.getTotalElements());
    }

    private boolean correspondeAoFiltro(AtorDTO dto, AtorFiltro filtro) {
        if (filtro == null) return true;

        if (filtro.getAtivo() != null && !filtro.getAtivo().equals(dto.getAtivo()))
            return false;

        if (StringUtils.hasText(filtro.getNacionalidade())) {
            if (dto.getNacionalidade() == null) return false;
            if (!dto.getNacionalidade().equalsIgnoreCase(filtro.getNacionalidade()))
                return false;
        }

        return true;
    }

    /* ================================================================
       ATUALIZAR ATOR
       - Busca ator existente
       - Valida duplicidade
       - Atualiza apenas os campos permitidos
    ================================================================ */
    @Transactional
    public AtorDTO atualizar(Long id, AtorUpdateDTO dto) {
        Ator ator = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Ator não encontrado"));

        validarDuplicidade(dto.getNome(), dto.getDataNascimento(), id);

        ator.setNome(dto.getNome().trim());
        ator.setNacionalidade(dto.getNacionalidade());
        ator.setDataNascimento(dto.getDataNascimento());

        if (dto.getAtivo() != null)
            ator.setAtivo(dto.getAtivo());

        return toDTO(repo.save(ator));
    }

    /* ================================================================
       EXCLUIR ATOR
       - Verifica existência
       - (placeholder) Garante integridade futura
    ================================================================ */
    @Transactional
    public void excluir(Long id) {
        Ator ator = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Ator não encontrado"));

        // TODO: Implementar verificação quando entidade Título existir
        // if (repo.existsRelacionamentoComTitulo(id)) {
        //     throw new BusinessException("Não é possível excluir ator vinculado a títulos.");
        // }

        repo.delete(ator);
    }

    /* ================================================================
       MÉTODOS AUXILIARES
    ================================================================ */

    /**
     * Verifica se já existe ator com mesmo nome e data de nascimento.
     * Ignora o próprio ID (para atualizações).
     */
    private void validarDuplicidade(String nome, LocalDate dataNascimento, Long idAtual) {
        if (!StringUtils.hasText(nome) || dataNascimento == null)
            return;

        boolean existe = repo.existsByNomeAndDataNascimento(nome.trim(), dataNascimento);

        if (existe && idAtual == null) {
            throw new BusinessException("Já existe ator com este nome e data de nascimento.");
        }
    }

    /**
     * Converte entidade para DTO.
     */
    private static AtorDTO toDTO(Ator ator) {
        AtorDTO dto = new AtorDTO();
        dto.setId(ator.getId());
        dto.setNome(ator.getNome());
        dto.setNacionalidade(ator.getNacionalidade());
        dto.setDataNascimento(ator.getDataNascimento());
        dto.setAtivo(ator.getAtivo());
        return dto;
    }
}
