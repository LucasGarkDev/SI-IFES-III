/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author jean_
 */
public enum Status {
    CADASTRADO ("Cadastrado"),
    ACEITO ("Aceito"),
    CANCELADO ("Cancelado"),
    EM_ENTREGA ("Em entrega"),
    ENTREGUE ("Entregue");
        
    private final String descricao;

    Status(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }

}
