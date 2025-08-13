/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package controladorcontador;

import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author lucas
 */
public class ControladorContador {

    public static void main(String[] args) {
        Contador contA = new Contador("ContadorA");
        Contador contB = new Contador("ContadorB");
        
        contA.start();
        
        try{
            contA.join();
        } catch (InterruptedException ex){
            Logger.getLogger(ControladorContador.class.getName()).log(Level.SEVERE,null,ex);
        }
    }
    
}
