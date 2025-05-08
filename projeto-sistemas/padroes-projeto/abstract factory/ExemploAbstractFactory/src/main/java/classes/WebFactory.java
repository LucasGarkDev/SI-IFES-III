/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package classes;

import interfaces.Notificacao;
import interfaces.PlataformaFactory;
import interfaces.Toast;

/**
 *
 * @author lucas
 */
public class WebFactory implements PlataformaFactory{

    private final Notificacao notificacaoTemplate;
    private final Toast toastTemplate;

    public WebFactory() {
        this.notificacaoTemplate = new WebNotificacao();
        this.toastTemplate = new WebToast();
    }
    
    @Override
    public void mostrarNotificacao(String mensagem) {
        notificacaoTemplate.exibir(mensagem);
    }

    @Override
    public void mostrarToast(String mensagem) {
        toastTemplate.mostrar(mensagem);
    }

    @Override
    public Notificacao getNotificacaoTemplate() {
        return notificacaoTemplate;
    }

    @Override
    public Toast getToastTemplate() {
        return toastTemplate;
    }
    
}
