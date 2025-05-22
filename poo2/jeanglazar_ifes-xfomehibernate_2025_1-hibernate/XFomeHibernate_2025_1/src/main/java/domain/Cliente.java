/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import controller.FuncoesUteis;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.*;
import org.hibernate.annotations.Check;



/**
 *
 * @author 1547816
 */

@Entity
@Table (name="ClienteBD")
@Check(constraints = "sexo IN ('M','F')")
public class Cliente implements Serializable {
    
    @Id
    @GeneratedValue ( strategy = GenerationType.IDENTITY )
    private int idCliente;
    
    @Column  ( name="nomeCliente" , nullable = false  ) 
    private String nome;
    
    @Column (unique = true, length = 14, updatable = false)
    private String cpf;
    
    @Temporal ( value = TemporalType.DATE )
    @Column (name="dataNascimento")
    private Date dtNasc;   
    
    @Column (length = 1 )
    private char sexo; 
    
    @Column (length = 15 )
    private String telFixo;
    
    @Column (length = 15 )
    private String celular;   
    
    @Column  ( nullable = false, insertable = false, columnDefinition = "varchar(100) DEFAULT 'email'" ) 
    private String email;
    
    @Lob
    private byte[] foto;

    @OneToOne (mappedBy = "cliente", cascade = CascadeType.ALL)
    private Endereco endereco;
    
    @ManyToOne
    @JoinColumn (name = "idCidade")
    private Cidade cidade;
    
    @OneToMany ( mappedBy = "cliente", fetch = FetchType.LAZY )
    private List<Pedido> pedidos;
    
    
    // PARA O HIBERNATE
    public Cliente() {
        
    }

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
        this.endereco.setCliente(this);
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
        this.endereco.setCliente(this);
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
