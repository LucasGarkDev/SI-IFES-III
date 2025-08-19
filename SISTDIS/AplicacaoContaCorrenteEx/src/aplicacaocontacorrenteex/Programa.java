/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aplicacaocontacorrenteex;

/**
 *
 * @author lucas
 */
public class Programa {
    
    public static void main(String[] args) { 
        
        ContaCorrente c = new ContaCorrente(1099,1000.90);
        
        Transacao tran = new Transacao(c);
        
        tran.start();
        
        tran.setValorDeposito(500);
        
        try{
            Thread.sleep(5000);
        } catch(InterruptedException e){
            System.out.println("ERRO: "+e.getMessage());
        }
        
        System.out.println("Saldo atualizado: $ "+c.obterSaldo());
    }
    
}
