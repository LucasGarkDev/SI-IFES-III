/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

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
@Check(constraints = "valorTotal >= 0 AND entregar IN ('S','N')")
public class Pedido implements Serializable {
    
    @Id
    @GeneratedValue ( strategy = GenerationType.IDENTITY )
    private int idPedido;   
    
    @Temporal ( value = TemporalType.DATE )
    private Date dtPedido;
    
    @Column ( length = 1)
    private char entregar;
    
    @Column(nullable = false, columnDefinition = "FLOAT DEFAULT 0.0")
    private float valorTotal;        
    
    @Enumerated(EnumType.STRING)
    private Status estado;

    
    @ManyToOne ( fetch = FetchType.EAGER )
    @JoinColumn ( name = "idCliente" )    
    private Cliente cliente;
    
    
    @OneToMany ( mappedBy = "chaveComposta.pedido", cascade = CascadeType.ALL)
    private List<ItemPedido> listaItensPedido;
    
    /*
    @ManyToMany ( fetch = FetchType.EAGER )
    @JoinTable ( name = "Pedido_Lanche" ,
                 joinColumns = { @JoinColumn(name = "idPedido" )   } ,
                 inverseJoinColumns = { @JoinColumn(name = "idLanche" )   }  ) 
    private List<Lanche> listaLanches;
    */

    public Pedido() {
    }

    public Pedido(Cliente cliente, Date dtPedido, char entregar, float valorTotal, List<ItemPedido> listaItensPedido) {
        this.dtPedido = dtPedido;
        this.entregar = entregar;
        this.valorTotal = valorTotal;
        this.estado = Status.CADASTRADO;
        this.cliente = cliente;
        this.listaItensPedido = listaItensPedido;
    }

    public Pedido(int idPedido, Cliente cliente, Date dtPedido, char entregar, float valorTotal, Status estado, List<ItemPedido> listaItensPedido) {
        this.idPedido = idPedido;
        this.dtPedido = dtPedido;
        this.entregar = entregar;
        this.valorTotal = valorTotal;
        this.estado = estado;
        this.cliente = cliente;
        this.listaItensPedido = listaItensPedido;
    }

    public int getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(int idPedido) {
        this.idPedido = idPedido;
    }

    public Date getDtPedido() {
        return dtPedido;
    }

    public void setDtPedido(Date dtPedido) {
        this.dtPedido = dtPedido;
    }

    public char getEntregar() {
        return entregar;
    }

    public void setEntregar(char entregar) {
        this.entregar = entregar;
    }

    public float getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(float valorTotal) {
        this.valorTotal = valorTotal;
    }

    public Status getEstado() {
        return estado;
    }

    public void setEstado(Status estado) {
        this.estado = estado;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public List<ItemPedido> getListaItensPedido() {
        return listaItensPedido;
    }

    public void setListaItensPedido(List<ItemPedido> listaItensPedido) {
        this.listaItensPedido = listaItensPedido;
    }

    
    
    
}
