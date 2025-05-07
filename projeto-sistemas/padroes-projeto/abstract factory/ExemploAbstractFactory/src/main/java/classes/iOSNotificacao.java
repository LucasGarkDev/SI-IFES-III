/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package classes;

import interfaces.Notificacao;
import javax.swing.JOptionPane;

/**
 *
 * @author lucas
 */
public class iOSNotificacao implements Notificacao{

    @Override
    public void exibir() {
        JOptionPane.showMessageDialog(null, "Notificação iOS: Novo evento no seu calendário!", "Notificação iOS", JOptionPane.WARNING_MESSAGE);
    }
    
}
