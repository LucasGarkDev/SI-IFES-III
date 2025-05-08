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
public class iOSFactory implements PlataformaFactory{

    private final Notificacao notificacaoTemplate;
    private final Toast toastTemplate;

    public iOSFactory() {
        this.notificacaoTemplate = new iOSNotificacao();
        this.toastTemplate = new iOSToast();
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
