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
public class AndroidFactory implements PlataformaFactory{

    private Notificacao notificacaoTemplate;
    private Toast toastTemplate;

    public AndroidFactory() {
        this.notificacaoTemplate = new AndroidNotificacao();
        this.toastTemplate = new AndroidToast();
    }

    @Override
    public void mostrarNotificacao(String mensagem) {
        notificacaoTemplate.exibir(mensagem);
    }
    @Override
    public void mostrarToast(String mensagem) {
        toastTemplate.mostrar(mensagem);
    }
}
