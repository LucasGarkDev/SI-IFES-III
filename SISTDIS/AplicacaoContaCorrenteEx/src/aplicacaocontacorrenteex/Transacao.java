/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aplicacaocontacorrenteex;

/**
 *
 * @author lucas
 */
public class Transacao extends Thread {
    private ContaCorrente conta;
    private double valorDeposito;
    
    public Transacao (ContaCorrente cc) {
        conta = cc;
        valorDeposito = 0;
    }
    
    @Override
    public void run(){
        while(true) {
            try{
                sleep(500);
                
                if (valorDeposito > 0){
                    conta.depositar(valorDeposito);
                    valorDeposito = 0;
                }
            } catch (InterruptedException e){
                System.out.println("ERRO: "+e.getMessage());
            }
        }
    }
    
    public void setValorDeposito(double valor) {
        valorDeposito = valor;
    }
    
}
