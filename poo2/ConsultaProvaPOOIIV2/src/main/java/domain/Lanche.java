/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author 1547816
 */
public class Lanche {
    
    private int idLanche;
    private String nome;
    private float valor;
    private String ingredientes;

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
