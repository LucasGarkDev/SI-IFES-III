/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;
import javax.persistence.*;

/**
 *
 * @author 1547816
 */


@Embeddable
public class ItemPedidoPK implements Serializable {
        
    @ManyToOne
    @JoinColumn (name = "idLanche")
    private Lanche lanche;
    
    @ManyToOne
    @JoinColumn (name = "idPedido")
    private Pedido pedido;

    public ItemPedidoPK(Lanche lanche, Pedido pedido) {
        this.lanche = lanche;
        this.pedido = pedido;
    }

    public ItemPedidoPK() {
    }

    public Lanche getLanche() {
        return lanche;
    }

    public void setLanche(Lanche lanche) {
        this.lanche = lanche;
    }

    public Pedido getPedido() {
        return pedido;
    }

    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }
 
    
    
}
