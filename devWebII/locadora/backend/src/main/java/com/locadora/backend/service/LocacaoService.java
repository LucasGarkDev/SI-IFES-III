/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.service;

import com.locadora.backend.domain.*;
import com.locadora.backend.dto.*;
import com.locadora.backend.exception.*;
import com.locadora.backend.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class LocacaoService {

    private final LocacaoRepository repo;
    private final ClienteRepository clienteRepo;
    private final ItemRepository itemRepo;

    public LocacaoService(LocacaoRepository repo, ClienteRepository clienteRepo, ItemRepository itemRepo) {
        this.repo = repo;
        this.clienteRepo = clienteRepo;
        this.itemRepo = itemRepo;
    }

    /* ================================================================
       EFETUAR NOVA LOCAÇÃO
    ================================================================ */
    @Transactional
    public LocacaoDTO criar(LocacaoCreateDTO dto) {
        Cliente cliente = clienteRepo.findById(dto.getClienteId())
                .orElseThrow(() -> new NotFoundException("Cliente não encontrado"));

        Item item = itemRepo.findById(dto.getItemId())
                .orElseThrow(() -> new NotFoundException("Item não encontrado"));

        // Cliente não pode ter locações em atraso
        if (repo.existsLocacaoEmDebito(cliente.getId(), LocalDate.now())) {
            throw new BusinessRuleException("Cliente possui locações em atraso.");
        }

        // Item deve estar disponível
        if (repo.existsLocacaoVigente(item.getId())) {
            throw new BusinessRuleException("Item já está locado.");
        }

        // Calcular valor e data prevista a partir da classe do título
        Classe classe = item.getTitulo().getClasse();
        LocalDate hoje = LocalDate.now();
        LocalDate dataPrevista = hoje.plusDays(classe.getDataDevolucao().getDayOfMonth());
        Integer valor = classe.getPrecoDiariaCentavos();

        Locacao loc = new Locacao();
        loc.setCliente(cliente);
        loc.setItem(item);
        loc.setDataLocacao(hoje);
        loc.setDataPrevistaDevolucao(dataPrevista);
        loc.setValorCentavos(valor);
        loc.setPaga(false);
        loc.setCancelada(false);

        return toDTO(repo.save(loc));
    }

    /*================================================================
       EFETUAR DEVOLUÇÃO
    =============================================================== */
    @Transactional
    public LocacaoDTO devolver(LocacaoDevolucaoDTO dto) {
        if (dto.getItemId() == null) {
            throw new BusinessRuleException("itemId é obrigatório.");
        }

        // (opcional) log rápido do que chegou
        // log.info("Devolução recebida: itemId={}, multa={}", dto.getItemId(), dto.getMulta());

        Item item = itemRepo.findById(dto.getItemId())
            .orElseThrow(() -> new NotFoundException("Item não encontrado pelo ID."));

        Locacao loc = repo.findLocacaoVigentePorItem(item.getId())
            .orElseThrow(() -> new BusinessRuleException("Item informado não possui locação vigente."));

        LocalDate hoje = LocalDate.now();
        loc.setDataEfetivaDevolucao(hoje);

        // Se veio multa do front, usa; senão calcula por atraso
        if (dto.getMulta() != null && dto.getMulta() > 0) {
            loc.setMultaCentavos((int) Math.round(dto.getMulta() * 100));
        } else {
            long atraso = ChronoUnit.DAYS.between(loc.getDataPrevistaDevolucao(), hoje);
            if (atraso > 0) {
                int multaCalc = (int) Math.round(atraso * (loc.getValorCentavos() * 0.1));
                loc.setMultaCentavos(multaCalc);
            } else {
                loc.setMultaCentavos(0);
            }
        }

        return toDTO(repo.save(loc));
    }

    /* ================================================================
       BUSCAR POR ID
    ================================================================ */
    @Transactional(readOnly = true)
    public LocacaoDTO buscarPorId(Long id) {
        Locacao loc = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Locação não encontrada"));
        return toDTO(loc);
    }

    /* ================================================================
       LISTAR TODAS
    ================================================================ */
    @Transactional(readOnly = true)
    public List<LocacaoDTO> listar() {
        return repo.findAll().stream().map(this::toDTO).toList();
    }

    /* ================================================================
       ATUALIZAR DADOS DE LOCAÇÃO
    ================================================================ */
    @Transactional
    public LocacaoDTO atualizar(Long id, LocacaoUpdateDTO dto) {
        Locacao loc = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Locação não encontrada"));

        if (loc.isCancelada()) throw new BusinessRuleException("Locação cancelada não pode ser alterada.");

        loc.setValorCentavos(dto.getValorCentavos());
        loc.setDataPrevistaDevolucao(dto.getDataPrevistaDevolucao());
        loc.setPaga(dto.getPaga());

        return toDTO(repo.save(loc));
    }

    /* ================================================================
       CANCELAR LOCAÇÃO
    ================================================================ */
    @Transactional
    public void cancelar(Long id) {
        Locacao loc = repo.findById(id)
                .orElseThrow(() -> new NotFoundException("Locação não encontrada"));

        if (loc.isPaga())
            throw new BusinessRuleException("Locação paga não pode ser cancelada.");

        loc.setCancelada(true);
        repo.save(loc);
    }

    /* ================================================================
       CONVERSÃO PARA DTO
    ================================================================ */
    private LocacaoDTO toDTO(Locacao loc) {
        LocacaoDTO dto = new LocacaoDTO();
        dto.setId(loc.getId());

        dto.setClienteId(loc.getCliente().getId());
        dto.setItemId(loc.getItem().getId());

        // 🔥 Preencher dados completos do cliente
        ClienteDTO c = new ClienteDTO();
        c.setId(loc.getCliente().getId());
        c.setNome(loc.getCliente().getNome());
        c.setNumInscricao(loc.getCliente().getNumInscricao());
        c.setSexo(loc.getCliente().getSexo());
        c.setDtNascimento(loc.getCliente().getDtNascimento());
        c.setEstaAtivo(loc.getCliente().getEstaAtivo());
        dto.setCliente(c);

        // 🔥 Preencher dados completos do item
        ItemDTO i = new ItemDTO();
        i.setId(loc.getItem().getId());
        i.setNumSerie(loc.getItem().getNumSerie());
        i.setDtAquisicao(loc.getItem().getDtAquisicao());
        i.setTipoItem(loc.getItem().getTipoItem());
        i.setTituloId(loc.getItem().getTitulo().getId());
        i.setTituloNome(loc.getItem().getTitulo().getNome());
        dto.setItem(i);

        dto.setDataLocacao(loc.getDataLocacao());
        dto.setDataPrevistaDevolucao(loc.getDataPrevistaDevolucao());
        dto.setDataEfetivaDevolucao(loc.getDataEfetivaDevolucao());
        dto.setValorCentavos(loc.getValorCentavos());
        dto.setMultaCentavos(loc.getMultaCentavos());
        dto.setPaga(loc.isPaga());
        dto.setCancelada(loc.isCancelada());

        return dto;
    }
}
