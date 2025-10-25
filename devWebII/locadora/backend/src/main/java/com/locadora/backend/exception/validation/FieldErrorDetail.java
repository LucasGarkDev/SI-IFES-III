/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception.validation;

/**
 * Representa detalhes de erro de validação em campos específicos,
 * usada principalmente em respostas 400 (Bad Request).
 */
public class FieldErrorDetail {

    private String field;
    private String message;

    public FieldErrorDetail() {
    }

    public FieldErrorDetail(String field, String message) {
        this.field = field;
        this.message = message;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
