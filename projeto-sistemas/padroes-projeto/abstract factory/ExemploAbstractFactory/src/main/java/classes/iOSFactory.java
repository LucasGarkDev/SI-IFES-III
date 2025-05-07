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

    @Override
    public Notificacao criarNotificacao() {
        return new iOSNotificacao();
    }

    @Override
    public Toast criarToast() {
        return new iOSToast();
    }
    
}
