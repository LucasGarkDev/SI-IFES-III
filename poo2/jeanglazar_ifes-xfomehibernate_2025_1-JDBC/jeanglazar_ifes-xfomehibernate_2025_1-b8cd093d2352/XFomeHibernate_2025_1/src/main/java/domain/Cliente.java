/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import controller.FuncoesUteis;
import java.util.Date;

/**
 *
 * @author 1547816
 */
public class Cliente {
     
    private int idCliente;
    private String nome;
    private String cpf;
    private Date dtNasc;   
    private char sexo;   
    private String telFixo;
    private String celular;    
    private String email;
    private byte[] foto;
    private Endereco endereco;
    private Cidade cidade;

    public Cliente(int idCliente, String nome, String cpf, Date dtNasc, char sexo, 
                    int idEndereco, String cep, String ender, int num, String complemento, 
                    String bairro, String referencia, String telFixo, String celular, 
                    String email, byte[] foto, Cidade cidade) {
        this.idCliente = idCliente;
        this.nome = nome;
        this.cpf = cpf;
        this.dtNasc = dtNasc;
        this.sexo = sexo;
        this.telFixo = telFixo;
        this.celular = celular;
        this.email = email;
        this.foto = foto;
        this.endereco = new Endereco(idEndereco, cep, bairro, ender, num, complemento, referencia);
        this.cidade = cidade;
    }
    

    public Cliente(String nome, String cpf, Date dtNasc, char sexo, String cep, 
                    String ender, int num, String complemento, String bairro, 
                    String referencia, String telFixo, String celular, String email, 
                    byte[] foto, Cidade cidade) {
        this.nome = nome;
        this.cpf = cpf;
        this.dtNasc = dtNasc;
        this.sexo = sexo;
        this.telFixo = telFixo;
        this.celular = celular;
        this.email = email;
        this.foto = foto;
        this.endereco = new Endereco(cep, bairro, ender, num, complemento, referencia);
        this.cidade = cidade;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public Date getDtNasc() {
        return dtNasc;
    }
    
    public String getDtNascFormatada() {
        return FuncoesUteis.dateToStr(dtNasc);
    }

    public void setDtNasc(Date dtNasc) {
        this.dtNasc = dtNasc;
    }

    public char getSexo() {
        return sexo;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    public String getTelFixo() {
        return telFixo;
    }

    public void setTelFixo(String telFixo) {
        this.telFixo = telFixo;
    }

    public String getCelular() {
        return celular;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public byte[] getFoto() {
        return foto;
    }

    public void setFoto(byte[] foto) {
        this.foto = foto;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public Cidade getCidade() {
        return cidade;
    }

    public void setCidade(Cidade cidade) {
        this.cidade = cidade;
    }

    @Override
    public String toString() {
        return nome;
    }
    
    
    
    
}
