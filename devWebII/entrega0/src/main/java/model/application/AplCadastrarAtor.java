/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.application;

import java.util.ArrayList;
import java.util.List;
import model.domain.Ator;

/**
 *
 * @author lucas
 */
public class AplCadastrarAtor {
    private static List<Ator> atores = new ArrayList<>();
    private static int contadorId = 1;

    public void adicionar(String nome) {
        atores.add(new Ator(contadorId++, nome));
    }

    public List<Ator> listar() {
        return new ArrayList<>(atores);
    }

    public void remover(int id) {
        atores.removeIf(ator -> ator.getId() == id);
    }

    public void atualizar(int id, String nome) {
        for (Ator ator : atores) {
            if (ator.getId() == id) {
                ator.setNome(nome);
                break;
            }
        }
    }

    public Ator buscar(int id) {
        for (Ator ator : atores) {
            if (ator.getId() == id) {
                return ator;
            }
        }
        return null;
    }
}
