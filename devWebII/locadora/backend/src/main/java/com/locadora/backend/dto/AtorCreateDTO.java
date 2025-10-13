package com.locadora.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Past;
import java.time.LocalDate;

public class AtorCreateDTO {
    @NotBlank(message = "Nome é obrigatório")
    private String nome;
//    private String nacionalidade;
//    @Past(message = "Data de nascimento deve estar no passado")
//    private LocalDate dataNascimento;

    // getters/setters
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }
//    public String getNacionalidade() { return nacionalidade; }
//    public void setNacionalidade(String nacionalidade) { this.nacionalidade = nacionalidade; }
//    public LocalDate getDataNascimento() { return dataNascimento; }
//    public void setDataNascimento(LocalDate dataNascimento) { this.dataNascimento = dataNascimento; }
}

