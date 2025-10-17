/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import java.time.LocalDate;

public class ClienteDTO {
    private Long id;
    private Long numInscricao;
    private String nome;
    private LocalDate dtNascimento;
    private String sexo;
    private Boolean estaAtivo;
    private String tipoCliente;

    // Getters e Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getNumInscricao() { return numInscricao; }
    public void setNumInscricao(Long numInscricao) { this.numInscricao = numInscricao; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public LocalDate getDtNascimento() { return dtNascimento; }
    public void setDtNascimento(LocalDate dtNascimento) { this.dtNascimento = dtNascimento; }

    public String getSexo() { return sexo; }
    public void setSexo(String sexo) { this.sexo = sexo; }

    public Boolean getEstaAtivo() { return estaAtivo; }
    public void setEstaAtivo(Boolean estaAtivo) { this.estaAtivo = estaAtivo; }

    public String getTipoCliente() { return tipoCliente; }
    public void setTipoCliente(String tipoCliente) { this.tipoCliente = tipoCliente; }
}

