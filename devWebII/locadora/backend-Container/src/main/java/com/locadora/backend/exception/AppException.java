/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception;
import org.springframework.http.HttpStatus;

/**
 * Classe base para todas as exceções customizadas do sistema Locadora.
 * Fornece o código HTTP e uma mensagem padronizada.
 */
public abstract class AppException extends RuntimeException {

    private final HttpStatus status;
    private final String code; // opcional, útil para padronizar respostas

    protected AppException(HttpStatus status, String message) {
        this(status, message, null);
    }

    protected AppException(HttpStatus status, String message, String code) {
        super(message);
        this.status = status;
        this.code = code;
    }

    public HttpStatus getStatus() {
        return status;
    }

    public String getCode() {
        return code;
    }
}
