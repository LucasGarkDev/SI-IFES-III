/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CidadeDAO;
import dao.ConexaoMySQL;
import dao.LancheDAO;
import domain.Cidade;
import domain.Lanche;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author 1547816
 */
public class GerenciadorDominio {

    private CidadeDAO cidDAO;
    private LancheDAO lanDAO;
//    private ClienteDAO cliDAO;
//    private PedidoDAO pedDAO;
    
    
    
    public GerenciadorDominio() throws ClassNotFoundException, SQLException {
        ConexaoMySQL.obterConexao();
        
        // Instânciar as classes DAO
        cidDAO = new CidadeDAO();
        lanDAO = new LancheDAO();
        
    }
    
    
    public List<Cidade> listarCidades() throws ClassNotFoundException, SQLException {
        return cidDAO.listar();      
    }
    
    public List<Lanche> listarLanches() throws ClassNotFoundException, SQLException {
        return lanDAO.listar();      
    }
    
    
    
    
    
        
    
    
}
