/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controladorcontador;

/**
 *
 * @author lucas
 */
public class Contador extends Thread {
    
    public Contador(String nome){
        super(nome);
    }
    
    public void run(){
        for(int conta = 0; conta < 10; conta++){
            System.out.println(getName() + "  "+ conta);
        }
    }
    
}
