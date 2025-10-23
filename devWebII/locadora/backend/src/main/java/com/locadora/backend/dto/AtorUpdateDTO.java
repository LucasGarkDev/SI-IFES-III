package com.locadora.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Past;
import java.time.LocalDate;

public class AtorUpdateDTO {
    @NotBlank(message = "Nome é obrigatório")
    private String nome;

    // getters/setters
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
}
