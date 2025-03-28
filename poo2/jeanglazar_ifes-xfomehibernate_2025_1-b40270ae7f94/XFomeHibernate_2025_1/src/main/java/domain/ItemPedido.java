package domain;




import java.io.Serializable;
import java.util.List;


/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author 1547816
 */

public class ItemPedido {
        
       
    // Somente para TESTE
    private String lanche;
    
    private int qtde;
    private String observacao;
    private int maisBife;
    private int maisOvo;
    private int maisPresunto;
    private int maisQueijo;
    private List ingredientes;


    public ItemPedido(String lanche, int qtde, int maisBife, int maisOvo, 
            int maisPresunto, int maisQueijo, String observacao, List ingredientes) {
        this.lanche = lanche;
        this.qtde = qtde;
        this.observacao = observacao;
        this.maisBife = maisBife;
        this.maisOvo = maisOvo;
        this.maisPresunto = maisPresunto;
        this.maisQueijo = maisQueijo;
        this.ingredientes = ingredientes;
    }

    public String getLanche() {
        return lanche;
    }

    public void setLanche(String lanche) {
        this.lanche = lanche;
    }

        
    public int getQtde() {
        return qtde;
    }

    public void setQtde(int qtde) {
        this.qtde = qtde;
    }

    public List  getIngredientes() {
        return ingredientes;
    }

    public void setIngredientes(List ingredientes) {
        this.ingredientes = ingredientes;
    }

    public int getMaisBife() {
        return maisBife;
    }

    public void setMaisBife(int maisBife) {
        this.maisBife = maisBife;
    }

    public int getMaisOvo() {
        return maisOvo;
    }

    public void setMaisOvo(int maisOvo) {
        this.maisOvo = maisOvo;
    }

    public int getMaisPresunto() {
        return maisPresunto;
    }

    public void setMaisPresunto(int maisPresunto) {
        this.maisPresunto = maisPresunto;
    }

    public int getMaisQueijo() {
        return maisQueijo;
    }

    public void setMaisQueijo(int maisQueijo) {
        this.maisQueijo = maisQueijo;
    }

    public String getObservacao() {
        return observacao;
    }

    public void setObservacao(String observacao) {
        this.observacao = observacao;
    }

    
    
}
