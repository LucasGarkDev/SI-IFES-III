/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import jakarta.validation.constraints.NotNull;


public class LocacaoDevolucaoDTO {
    @NotNull(message = "itemId é obrigatório")
    private Long itemId;

    private Double multa; // opcional

    public Long getItemId() { return itemId; }
    public void setItemId(Long itemId) { this.itemId = itemId; }

    public Double getMulta() { return multa; }
    public void setMulta(Double multa) { this.multa = multa; }
}