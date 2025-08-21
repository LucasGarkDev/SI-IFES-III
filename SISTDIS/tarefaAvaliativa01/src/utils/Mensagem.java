/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author lucas
 */
public class Mensagem {
    private String tipo;       // "MSG" ou "PING"
    private String usuario;
    private String conteudo;

    public Mensagem(String tipo, String usuario, String conteudo) {
        this.tipo = tipo;
        this.usuario = usuario;
        this.conteudo = conteudo;
    }

    public String getTipo() {
        return tipo;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getConteudo() {
        return conteudo;
    }

    @Override
    public String toString() {
        return tipo + ";" + usuario + ";" + conteudo;
    }

    public static Mensagem fromString(String raw) {
        String[] partes = raw.split(";", 3);
        return new Mensagem(partes[0], partes[1], partes.length == 3 ? partes[2] : "");
    }
}
