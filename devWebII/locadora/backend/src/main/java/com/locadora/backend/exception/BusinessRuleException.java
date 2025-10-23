/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.exception;

import org.springframework.http.HttpStatus;

/**
 * Lançada quando alguma regra de negócio é violada.
 */
public class BusinessRuleException extends AppException {

    public BusinessRuleException(String message) {
        super(HttpStatus.BAD_REQUEST, message);
    }
}