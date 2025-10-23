package com.locadora.backend.controller.advice;

import com.locadora.backend.exception.AppException;
import com.locadora.backend.exception.validation.FieldErrorDetail;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.OffsetDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Manipulador global de exceções da API da Locadora.
 * Responsável por transformar exceções internas em respostas HTTP padronizadas.
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * Trata exceções customizadas do sistema (que herdam de AppException).
     */
    @ExceptionHandler(AppException.class)
    public ResponseEntity<ErrorResponse> handleAppException(AppException ex, HttpServletRequest req) {
        ErrorResponse body = new ErrorResponse(
                OffsetDateTime.now(),
                ex.getStatus().value(),
                ex.getStatus().getReasonPhrase(),
                ex.getMessage(),
                req.getRequestURI(),
                null
        );
        return ResponseEntity.status(ex.getStatus()).body(body);
    }

    /**
     * Trata erros de validação de campos (@Valid).
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex, HttpServletRequest req) {
        List<FieldErrorDetail> fieldErrors = ex.getBindingResult().getFieldErrors()
                .stream()
                .map(fe -> new FieldErrorDetail(fe.getField(), fe.getDefaultMessage()))
                .collect(Collectors.toList());

        ErrorResponse body = new ErrorResponse(
                OffsetDateTime.now(),
                HttpStatus.BAD_REQUEST.value(),
                "Bad Request",
                "Erro de validação nos campos informados",
                req.getRequestURI(),
                fieldErrors
        );
        return ResponseEntity.badRequest().body(body);
    }

    /**
     * Trata violações de integridade do banco (ex: chave duplicada).
     */
    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<ErrorResponse> handleDataIntegrity(DataIntegrityViolationException ex, HttpServletRequest req) {
        ErrorResponse body = new ErrorResponse(
                OffsetDateTime.now(),
                HttpStatus.CONFLICT.value(),
                "Conflict",
                "Violação de integridade de dados no banco de dados.",
                req.getRequestURI(),
                null
        );
        return ResponseEntity.status(HttpStatus.CONFLICT).body(body);
    }

    /**
     * Trata qualquer outra exceção não mapeada.
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleUnexpected(Exception ex, HttpServletRequest req) {
        ex.printStackTrace(); // opcional: logar com logger

        ErrorResponse body = new ErrorResponse(
                OffsetDateTime.now(),
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "Internal Server Error",
                "Ocorreu um erro inesperado no servidor.",
                req.getRequestURI(),
                null
        );
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(body);
    }

    /**
     * Modelo de corpo padrão de resposta de erro.
     */
    public record ErrorResponse(
            OffsetDateTime timestamp,
            int status,
            String error,
            String message,
            String path,
            List<FieldErrorDetail> errors
    ) {}
}

