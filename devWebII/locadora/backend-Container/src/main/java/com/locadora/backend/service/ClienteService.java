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
import java.util.concurrent.atomic.AtomicLong;
import java.util.stream.Collectors;

@Service
public class ClienteService {

    private final ClienteRepository clienteRepo;
    private final SocioRepository socioRepo;
    private final DependenteRepository dependenteRepo;
    private static final AtomicLong contadorInscricao = new AtomicLong(1000);

    public ClienteService(ClienteRepository clienteRepo, SocioRepository socioRepo, DependenteRepository dependenteRepo) {
        this.clienteRepo = clienteRepo;
        this.socioRepo = socioRepo;
        this.dependenteRepo = dependenteRepo;
    }

    /* ======================================
       CRIAR NOVO SÓCIO E SEUS DEPENDENTES
    ====================================== */
    @Transactional
    public ClienteDTO criarSocio(SocioCreateDTO dto) {
        if (socioRepo.existsByCpf(dto.getCpf())) {
            throw new BusinessRuleException("Já existe sócio com este CPF.");
        }

        Socio socio = new Socio();
        socio.setNumInscricao(contadorInscricao.incrementAndGet());
        socio.setNome(dto.getNome());
        socio.setDtNascimento(dto.getDtNascimento());
        socio.setSexo(dto.getSexo());
        socio.setCpf(dto.getCpf());
        socio.setEndereco(dto.getEndereco());
        socio.setTelefone(dto.getTelefone());
        socio.setEstaAtivo(true);

        if (dto.getDependentes() != null && !dto.getDependentes().isEmpty()) {
            if (dto.getDependentes().size() > 3)
                throw new BusinessRuleException("Um sócio não pode ter mais de 3 dependentes ativos.");

            dto.getDependentes().forEach(depDto -> {
                Dependente d = new Dependente();
                d.setNumInscricao(contadorInscricao.incrementAndGet());
                d.setNome(depDto.getNome());
                d.setSexo(depDto.getSexo());
                d.setDtNascimento(depDto.getDtNascimento());
                d.setSocio(socio);
                d.setEstaAtivo(true);
                socio.getDependentes().add(d);
            });
        }

        return toDTO(socioRepo.save(socio));
    }

    /* ======================================
       CONSULTAR, LISTAR, ATUALIZAR, EXCLUIR
    ====================================== */
    @Transactional(readOnly = true)
    public Page<ClienteDTO> listar(ClienteFiltro filtro, Pageable pageable) {
        Page<Cliente> page;
        if (filtro != null && StringUtils.hasText(filtro.getNome()))
            page = clienteRepo.findByNomeContainingIgnoreCase(filtro.getNome(), pageable);
        else
            page = clienteRepo.findAll(pageable);

        List<ClienteDTO> content = page.getContent().stream()
                .map(this::toDTO)
                .filter(dto -> filtro == null ||
                        (filtro.getEstaAtivo() == null || dto.getEstaAtivo().equals(filtro.getEstaAtivo())) &&
                        (filtro.getTipoCliente() == null || dto.getTipoCliente().equalsIgnoreCase(filtro.getTipoCliente()))
                )
                .collect(Collectors.toList());

        return new PageImpl<>(content, pageable, page.getTotalElements());
    }

    @Transactional
    public void excluir(Long id) {
        Cliente cliente = clienteRepo.findById(id)
                .orElseThrow(() -> new NotFoundException("Cliente não encontrado."));

        try {
            if (cliente instanceof Socio socio) {
                socio.getDependentes().forEach(dependenteRepo::delete);
            }

            clienteRepo.delete(cliente);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegrityException("Não é possível excluir o cliente, pois ele está vinculado a locações ou outros registros.");
        }
    }

    private ClienteDTO toDTO(Cliente c) {
        ClienteDTO dto = new ClienteDTO();
        dto.setId(c.getId());
        dto.setNumInscricao(c.getNumInscricao());
        dto.setNome(c.getNome());
        dto.setDtNascimento(c.getDtNascimento());
        dto.setSexo(c.getSexo());
        dto.setEstaAtivo(c.getEstaAtivo());
        dto.setTipoCliente(c instanceof Socio ? "SOCIO" : "DEPENDENTE");
        return dto;
    }
}
