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
        PlataformaFactory plataforma;

        try {
            // Android
            plataforma = new AndroidFactory();
            Notificacao notificacaoAndroid = plataforma.criarNotificacao();
            Toast toastAndroid = plataforma.criarToast();
            notificacaoAndroid.exibir();
            toastAndroid.mostrar();
            Thread.sleep(2500); 

            // iOS
            plataforma = new iOSFactory();
            Notificacao notificacaoiOS = plataforma.criarNotificacao();
            Toast toastiOS = plataforma.criarToast();
            notificacaoiOS.exibir();
            toastiOS.mostrar();
            Thread.sleep(2500);

            // Web
            plataforma = new WebFactory();
            Notificacao notificacaoWeb = plataforma.criarNotificacao();
            Toast toastWeb = plataforma.criarToast();
            notificacaoWeb.exibir();
            toastWeb.mostrar();

        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
