/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.ClienteDAO;
import dao.ConexaoHibernate;
import dao.GenericDAO;
import domain.Cidade;
import domain.Cliente;
import domain.ItemPedido;
import domain.Pedido;
import java.util.Date;
import java.util.List;
import javax.swing.Icon;
import org.hibernate.HibernateException;

/**
 *
 * @author 1547816
 */
public class GerenciadorDominio {

    private ClienteDAO cliDAO;
    private GenericDAO genDAO;
//    private PedidoDAO pedDAO;
    
    
    
    public GerenciadorDominio() throws java.lang.ExceptionInInitializerError, HibernateException {
        // ConexaoMySQL.obterConexao();
        ConexaoHibernate.getSessionFactory().openSession();
        
        // Instânciar as classes DAO
        cliDAO = new ClienteDAO();
        genDAO = new GenericDAO();
        
    }

    // ######  MÉTODOS GENÉRICOS   ####
    
    public List listar(Class classe) throws HibernateException {
        return genDAO.listar(classe);      
    }
    
    public void excluir(Object obj) throws HibernateException {
        genDAO.excluir(obj);
    }
    
    // ##############

        
    public Cliente inserirCliente(String nome, String cpf, Date dtNasc, char sexo,
            String cep, String ender, int num, String complemento, String bairro,
            String referencia, String telFixo, String celular, String email, Icon foto, Cidade cidade) throws HibernateException  {

            Cliente cli = new Cliente(nome, cpf, dtNasc, sexo, cep, ender, num, 
                    complemento, bairro, referencia, telFixo, celular, email, 
                    FuncoesUteis.IconToBytes(foto), cidade);
            
            cliDAO.inserir(cli);
            return cli;
        
    }
    
    public Cliente alterarCliente(Cliente cli, String nome, String cpf, Date dtNasc, char sexo,
            String cep, String ender, int num, String complemento, String bairro,
            String referencia, String telFixo, String celular, String email, Icon foto, Cidade cidade) throws HibernateException  {

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
        
    
    public List<Cliente> pesquisarCliente(String pesq, int tipo) throws HibernateException {
        
        switch ( tipo ) {
            case 1: return cliDAO.pesquisarPorNome(pesq); 
            case 2: return cliDAO.pesquisarPorCPF(pesq); 
            case 3: return cliDAO.pesquisarPorBairro(pesq); 
            case 4: return cliDAO.pesquisarPorMes(pesq); 
            default: return null;                    
        }
                
    }
    
    
    
    public Pedido inserirPedido(Cliente cliente, char entregar, List<ItemPedido> listaItensPedido) {
        
        Pedido ped = new Pedido(cliente, new Date(), entregar, (float) 0.0, listaItensPedido);

        float total = (float) 0.0;
        
        // ATUALIZAR A REFERENCIA DO PEDIDO DENTRO DA LISTA DE ITENS
        for (ItemPedido itemPedido : listaItensPedido) {
            itemPedido.setPedido(ped);
            total = total + itemPedido.getQtde() * itemPedido.getLanche().getValor();
        }
        ped.setValorTotal(total);
        
        genDAO.inserir(ped);
        return ped;
    }
    
    
        
    
    
}
