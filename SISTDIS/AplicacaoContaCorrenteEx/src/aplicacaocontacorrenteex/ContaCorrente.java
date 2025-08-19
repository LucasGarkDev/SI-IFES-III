/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aplicacaocontacorrenteex;

/**
 *
 * @author lucas
 */
public class ContaCorrente {
    
    private int numero;
    private double saldo;

    public ContaCorrente(int numero, double saldo) {
        this.numero = numero;
        this.saldo = saldo;
    }
    
    public synchronized void depositar(double valor){
        if(valor > 0){
            saldo = saldo + valor;
        }
    }
    
    public synchronized boolean sacar(double valor){
        boolean resposta = false;
        if(valor <= saldo){
            if(valor > 0){
                saldo = saldo - valor;
                resposta = true;
            }
        }
        return resposta;
    }
    
    public double obterSaldo(){
        return saldo;
    }
    
}
