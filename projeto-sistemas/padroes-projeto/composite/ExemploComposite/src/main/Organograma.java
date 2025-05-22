/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package main;

import classes.Empregado;
import classes.Funcionario;
import classes.Gerente;

/**
 *
 * @author lucas
 */
public class Organograma {
    public static void main(String[] args) {
        Funcionario gerenteGeral = new Gerente("Carlos", "Diretor Executivo");
        Funcionario gerenteTI = new Gerente("Fernanda", "Gerente de TI");

        Funcionario dev1 = new Empregado("João", "Desenvolvedor Java");
        Funcionario dev2 = new Empregado("Maria", "Desenvolvedora Front-End");

        gerenteTI.adicionar(dev1);
        gerenteTI.adicionar(dev2);

        gerenteGeral.adicionar(gerenteTI);

        gerenteGeral.exibirInformacoes();
    }
}
