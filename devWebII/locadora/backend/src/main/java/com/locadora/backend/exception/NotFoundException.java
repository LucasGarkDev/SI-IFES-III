/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception;

import org.springframework.http.HttpStatus;

/**
 * Lançada quando um recurso solicitado não é encontrado.
 */
public class NotFoundException extends AppException {

    public NotFoundException(String message) {
        super(HttpStatus.NOT_FOUND, message);
    }
}
