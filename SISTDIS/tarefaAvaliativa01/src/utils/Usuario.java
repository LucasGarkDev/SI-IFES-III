/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author lucas
 */
public class Usuario {
    private String nome;
    private boolean online;

    public Usuario(String nome) {
        this.nome = nome;
        this.online = true;
    }

    public String getNome() {
        return nome;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    @Override
    public String toString() {
        return nome + (online ? " (online)" : " (offline)");
    }
}
