/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package classes;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lucas
 */
public class Gerente extends Funcionario {
    
    private List<Funcionario> subordinados = new ArrayList<>();

    public Gerente(String nome, String cargo) {
        super(nome, cargo);
    }

    public void adicionar(Funcionario f) {
        subordinados.add(f);
    }

    public void remover(Funcionario f) {
        subordinados.remove(f);
    }

    @Override
    public void exibirInformacoes() {
        System.out.println("Gerente: " + nome + " - " + cargo);
        for (Funcionario f : subordinados) {
            f.exibirInformacoes();
        }
    }
    
}
