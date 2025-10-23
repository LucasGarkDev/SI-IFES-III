/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception;

import org.springframework.http.HttpStatus;

/**
 * Lançada quando ocorre violação de integridade referencial ou de constraints no banco de dados.
 */
public class DataIntegrityException extends AppException {

    public DataIntegrityException(String message) {
        super(HttpStatus.CONFLICT, message);
    }
}
