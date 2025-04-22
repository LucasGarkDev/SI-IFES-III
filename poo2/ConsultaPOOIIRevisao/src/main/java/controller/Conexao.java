/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author lucas
 */
public class Conexao {
    
    
    // 🔁 Modifique apenas essas variáveis na prova, conforme o PDF
    private static final String URL = "jdbc:mysql://localhost:3306/estoque"; // Nome do banco
    private static final String USER = "root"; // Usuário do banco
    private static final String PASSWORD = "123456"; // Senha do banco
    
//    private static final String URL = "jdbc:postgresql://localhost:5432/bancodaprove";
//    private static final String USER = "postgres";
//    private static final String PASSWORD = "123456";
//    Class.forName("org.postgresql.Driver");

    // 🚀 Novo: Carrega o driver automaticamente (ainda que seja opcional no JDBC moderno)
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 8+ do MySQL
        } catch (ClassNotFoundException e) {
            System.err.println("Driver JDBC não encontrado!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
