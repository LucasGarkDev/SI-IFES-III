/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.dto;

import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;

public class LocacaoUpdateDTO {

    @NotNull(message = "Valor é obrigatório")
    private Integer valorCentavos;

    @NotNull(message = "Data prevista é obrigatória")
    private LocalDate dataPrevistaDevolucao;

    private Boolean paga;

    public Integer getValorCentavos() { return valorCentavos; }
    public void setValorCentavos(Integer valorCentavos) { this.valorCentavos = valorCentavos; }

    public LocalDate getDataPrevistaDevolucao() { return dataPrevistaDevolucao; }
    public void setDataPrevistaDevolucao(LocalDate dataPrevistaDevolucao) { this.dataPrevistaDevolucao = dataPrevistaDevolucao; }

    public Boolean getPaga() { return paga; }
    public void setPaga(Boolean paga) { this.paga = paga; }
}
