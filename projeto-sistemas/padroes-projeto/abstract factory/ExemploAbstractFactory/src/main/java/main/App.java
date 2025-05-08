/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package main;

import classes.AndroidFactory;
import classes.WebFactory;
import classes.iOSFactory;
import interfaces.Notificacao;
import interfaces.PlataformaFactory;
import interfaces.Toast;

/**
 *
 * @author lucas
 */
public class App {
    public static void main(String[] args) {
        String plataformaSelecionada = "android"; // Pode ser "ios", "android", "web"

        PlataformaFactory fabrica = criarFabrica(plataformaSelecionada);

        if (fabrica == null) {
            System.out.println("Plataforma inválida.");
            return;
        }

        // Uso direto dos templates (justifica o relacionamento no diagrama)
        Notificacao notificacao = fabrica.getNotificacaoTemplate();
        Toast toast = fabrica.getToastTemplate();

        notificacao.exibir("Bem-vindo ao sistema!");
        toast.mostrar("Login efetuado com sucesso!");

        // Uso padrão via fábrica
//        fabrica.mostrarNotificacao("Bem-vindo ao sistema!");
//        fabrica.mostrarToast("Login efetuado com sucesso!");
    }

    private static PlataformaFactory criarFabrica(String plataforma) {
        switch (plataforma.toLowerCase()) {
            case "android": return new AndroidFactory();
            case "ios":     return new iOSFactory();
            case "web":     return new WebFactory();
            default:        return null;
        }
    }
}
