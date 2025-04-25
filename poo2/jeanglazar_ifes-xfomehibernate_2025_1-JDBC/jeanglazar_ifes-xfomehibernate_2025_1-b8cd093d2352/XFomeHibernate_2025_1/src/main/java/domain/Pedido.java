/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.util.Date;
import java.util.List;

/**
 *
 * @author 1547816
 */
public class Pedido {
    
    private int idPedido;    
    private Date dtPedido;
    private char entregar;
    private float valorTotal;        
    
//    private Cliente cliente;
    
    private List<ItemPedido> itensPedido;
    
}
