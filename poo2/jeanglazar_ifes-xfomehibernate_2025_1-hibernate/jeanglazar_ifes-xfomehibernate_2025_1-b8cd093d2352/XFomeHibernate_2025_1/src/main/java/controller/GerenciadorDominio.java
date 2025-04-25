/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.CidadeDAO;
import dao.ClienteDAO;
import dao.ConexaoMySQL;
import dao.LancheDAO;
import domain.Cidade;
import domain.Cliente;
import domain.Lanche;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import javax.swing.Icon;

/**
 *
 * @author 1547816
 */
public class GerenciadorDominio {

    private CidadeDAO cidDAO;
    private LancheDAO lanDAO;
    private ClienteDAO cliDAO;
//    private PedidoDAO pedDAO;
    
    
    
    public GerenciadorDominio() throws ClassNotFoundException, SQLException {
        ConexaoMySQL.obterConexao();
        
        // Instânciar as classes DAO
        cidDAO = new CidadeDAO();
        lanDAO = new LancheDAO();
        cliDAO = new ClienteDAO();
        
    }
    
    
    public List<Cidade> listarCidades() throws ClassNotFoundException, SQLException {
        return cidDAO.listar();      
    }
    
    public List<Lanche> listarLanches() throws ClassNotFoundException, SQLException {
        return lanDAO.listar();      
    }
    
    public Cliente inserirCliente(String nome, String cpf, Date dtNasc, char sexo,
            String cep, String ender, int num, String complemento, String bairro,
            String referencia, String telFixo, String celular, String email, Icon foto, Cidade cidade) throws ClassNotFoundException, SQLException  {

            Cliente cli = new Cliente(nome, cpf, dtNasc, sexo, cep, ender, num, 
                    complemento, bairro, referencia, telFixo, celular, email, 
                    FuncoesUteis.IconToBytes(foto), cidade);
            
            cliDAO.inserir(cli);
            return cli;
        
    }
    
    public Cliente alterarCliente(Cliente cli, String nome, String cpf, Date dtNasc, char sexo,
            String cep, String ender, int num, String complemento, String bairro,
            String referencia, String telFixo, String celular, String email, Icon foto, Cidade cidade) throws ClassNotFoundException, SQLException  {

            cli.setNome(nome);
            cli.setCpf(cpf);
            cli.setDtNasc(dtNasc);
            cli.setSexo(sexo);
            cli.getEndereco().setCep(cep);
            cli.getEndereco().setLogradouro(ender);
            cli.getEndereco().setNumero(num);
            cli.getEndereco().setComplemento(complemento);
            cli.getEndereco().setBairro(bairro);
            cli.getEndereco().setReferencia(referencia);
            cli.setTelFixo(telFixo);
            cli.setCelular(celular);
            cli.setEmail(email);
            cli.setFoto( FuncoesUteis.IconToBytes(foto) );
            cli.setCidade(cidade);
                        
            cliDAO.alterar(cli);
            return cli;
        
    }
    
    public void excluirCliente(Cliente cli) throws ClassNotFoundException, SQLException {
        cliDAO.excluir(cli);
    }
    
    
    public List<Cliente> pesquisarCliente(String pesq, int tipo) throws ClassNotFoundException, SQLException {
        
        switch ( tipo ) {
            case 1: return cliDAO.pesquisarPorNome(pesq); 
            case 2: return cliDAO.pesquisarPorCPF(pesq); 
            case 3: return cliDAO.pesquisarPorBairro(pesq); 
            case 4: return cliDAO.pesquisarPorMes(pesq); 
            default: return null;                    
        }
                
    }
    
    
    
    
    
        
    
    
}
