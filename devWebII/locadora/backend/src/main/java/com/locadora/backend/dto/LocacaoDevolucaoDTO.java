/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import jakarta.validation.constraints.NotBlank;

public class LocacaoDevolucaoDTO {

    @NotBlank(message = "Número de série do item é obrigatório")
    private String numeroSerie;

    public String getNumeroSerie() { return numeroSerie; }
    public void setNumeroSerie(String numeroSerie) { this.numeroSerie = numeroSerie; }
}

