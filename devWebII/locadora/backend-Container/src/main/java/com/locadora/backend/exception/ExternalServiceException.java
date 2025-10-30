/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception;

import org.springframework.http.HttpStatus;

/**
 * Lançada quando ocorre falha em comunicação com serviços externos (ex: API, Storage, Gateway de Pagamento).
 */
public class ExternalServiceException extends AppException {

    public ExternalServiceException(String message) {
        super(HttpStatus.BAD_GATEWAY, message);
    }
}
