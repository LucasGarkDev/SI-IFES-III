/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package main;

import classes.Macarronada;
import classes.Massa;
import classes.Pizza;
import decorator.MolhoTomate;
import decorator.Queijo;

/**
 *
 * @author lucas
 */
public class Cliente {
    public static void main(String[] args) {
        // Macarronada com queijo e molho de tomate
        Massa massa = new Macarronada();
        massa = new Queijo(massa);
        massa = new MolhoTomate(massa);

        System.out.println(massa.getDescricao()); // Macarronada com queijo com molho de tomate
        System.out.println("Preço: R$ " + massa.getPreco()); // Exemplo: 17.0 + 2.0 + 1.5 = 20.5
    }
}

