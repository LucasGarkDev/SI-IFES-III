/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author 1547816
 */
@Entity
public class Lanche implements Serializable {
    
    @Id
    @GeneratedValue ( strategy = GenerationType.IDENTITY )
    private int idLanche;
    
    private String nome;
    private float valor;
    private String ingredientes;
    
    @OneToMany ( mappedBy = "chaveComposta.lanche")
    private List<ItemPedido> listaItensPedido;
    
    /*
    @ManyToMany ( mappedBy = "listaLanches", fetch = FetchType.LAZY )
    private List<Pedido> listaPedidos;
    */

    public Lanche() {
    }

    public Lanche(int idLanche, String nome, float valor, String ingredientes) {
        this.idLanche = idLanche;
        this.nome = nome;
        this.valor = valor;
        this.ingredientes = ingredientes;
    }

    public int getIdLanche() {
        return idLanche;
    }

    public void setIdLanche(int idLanche) {
        this.idLanche = idLanche;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public String getIngredientes() {
        return ingredientes;
    }

    public void setIngredientes(String ingredientes) {
        this.ingredientes = ingredientes;
    }

    @Override
    public String toString() {
        return nome + " - R$ " + valor;
    }
    
    
    
}
