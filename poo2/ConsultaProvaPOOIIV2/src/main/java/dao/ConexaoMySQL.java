/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author 1547816
 */
public class ConexaoMySQL {
     private static Connection conexao = null;
     // Dados da conexão (ATUALIZADO)
    private static final String SERVIDOR = "localhost";  // Ou IP do servidor
    private static final String BANCO = "jeanxfome";      // Novo nome do banco de dados
    private static final String USUARIO = "postgres";     // Usuário do PostgreSQL
    private static final String SENHA = "123";            // Senha do PostgreSQL
    private static final String URL = "jdbc:postgresql://" + SERVIDOR + "/" + BANCO;

    // Construtor privado para evitar instanciação externa
    private ConexaoMySQL() {}

    // Método para obter a conexão única (Singleton)
    public static Connection obterConexao() {
        if (conexao == null) {
            try {
                Class.forName("org.postgresql.Driver");
                conexao = DriverManager.getConnection(URL, USUARIO, SENHA);
                System.out.println("Conexão com o banco 'jeanxfome' estabelecida com sucesso!");
            } catch (ClassNotFoundException e) {
                JOptionPane.showMessageDialog(null, "Driver JDBC não encontrado!", "Erro", JOptionPane.ERROR_MESSAGE);
                System.exit(1); // Encerra a aplicação
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Erro ao conectar ao banco: " + e.getMessage(), "Erro", JOptionPane.ERROR_MESSAGE);
                System.exit(1); // Encerra a aplicação
            }
        }
        return conexao;
    }

    // Método para fechar a conexão (opcional)
    public static void fecharConexao() {
        if (conexao != null) {
            try {
                conexao.close();
                conexao = null;
                System.out.println("Conexão com o banco de dados fechada.");
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(null, "Erro ao fechar conexão!", "Erro", JOptionPane.ERROR_MESSAGE);
            }
        }
    }
            
}
