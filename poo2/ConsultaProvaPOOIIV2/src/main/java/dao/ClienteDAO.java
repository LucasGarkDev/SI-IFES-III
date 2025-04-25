/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import domain.Cidade;
import domain.Cliente;
import domain.Endereco;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author 1547816
 */
public class ClienteDAO {
 
    public void inserir(Cliente cli) throws ClassNotFoundException, SQLException {
        
        String sql = "INSERT INTO Cliente (nome, cpf, dtNasc, sexo, telefone, "
                + "celular, email, foto, idCidade ) VALUES (?,?,?,?,?,?,?,?,? )";
        
        PreparedStatement stmt = ConexaoMySQL.obterConexao().prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        
        int col = 1;
        stmt.setString(col++, cli.getNome() );
        stmt.setString(col++, cli.getCpf() );
        stmt.setDate(col++, new java.sql.Date( cli.getDtNasc().getTime() ) );
        stmt.setString(col++, String.valueOf( cli.getSexo() ) );       
        stmt.setString(col++, cli.getTelFixo() );
        stmt.setString(col++, cli.getCelular() );
        stmt.setString(col++, cli.getEmail() );
        stmt.setBytes(col++, cli.getFoto() );
        stmt.setInt(col++, cli.getCidade().getIdCidade() );
        
        stmt.execute();
                       
        // PEGAR O NÚMERO GERADO
        ResultSet rs = stmt.getGeneratedKeys();
        if ( rs.next() ) {
            int id = rs.getInt(1);            
            cli.setIdCliente(id);
            cli.getEndereco().setIdEndereco(id);
        }
        
        inserirEndereco( cli.getEndereco() );
        
    }
    
    private void inserirEndereco(Endereco end) throws ClassNotFoundException, SQLException {
         String sql = "INSERT INTO Endereco (idEndereco, cep, logradouro,"
                 + "numero, bairro, complemento, referencia ) VALUES (?,?,?,?,?,?,? )";
        
        PreparedStatement stmt = ConexaoMySQL.obterConexao().prepareStatement(sql);
        
        int col = 1;
        stmt.setInt(col++, end.getIdEndereco() );
        stmt.setString(col++, end.getCep() );
        stmt.setString(col++, end.getLogradouro() );
        stmt.setInt(col++, end.getNumero() );        
        stmt.setString(col++, end.getBairro() );
        stmt.setString(col++, end.getComplemento() );
        stmt.setString(col++, end.getReferencia() );
        
        stmt.execute();
    }
    
    public void alterar(Cliente cli) throws ClassNotFoundException, SQLException {
        
        String sql = "UPDATE Cliente SET "
                + "nome=?, cpf=?, dtNasc=?, sexo=?, telefone=?, "
                + "celular=?, email=?, foto=?, idCidade=?  "
                + "WHERE idCliente = " + cli.getIdCliente();
        
        PreparedStatement stmt = ConexaoMySQL.obterConexao().prepareStatement(sql);
        
        int col = 1;
        stmt.setString(col++, cli.getNome() );
        stmt.setString(col++, cli.getCpf() );
        stmt.setDate(col++, new java.sql.Date( cli.getDtNasc().getTime() ) );
        stmt.setString(col++, String.valueOf( cli.getSexo() ) );       
        stmt.setString(col++, cli.getTelFixo() );
        stmt.setString(col++, cli.getCelular() );
        stmt.setString(col++, cli.getEmail() );
        stmt.setBytes(col++, cli.getFoto() );
        stmt.setInt(col++, cli.getCidade().getIdCidade() );
        
        stmt.execute();                              
        
        alterarEndereco( cli.getEndereco() );
            
    }
    
    private void alterarEndereco(Endereco end) throws ClassNotFoundException, SQLException {
         String sql = "UPDATE Endereco SET "
                 + "cep=?, logradouro=?, numero=?, bairro=?, complemento=?, referencia=? "
                 + "WHERE idEndereco = " + end.getIdEndereco();
        
        PreparedStatement stmt = ConexaoMySQL.obterConexao().prepareStatement(sql);
        
        int col = 1;
        stmt.setString(col++, end.getCep() );
        stmt.setString(col++, end.getLogradouro() );
        stmt.setInt(col++, end.getNumero() );        
        stmt.setString(col++, end.getBairro() );
        stmt.setString(col++, end.getComplemento() );
        stmt.setString(col++, end.getReferencia() );
        
        stmt.execute();
    }
    
    public void excluir(Cliente cli) throws ClassNotFoundException, SQLException {
        Statement stmt = ConexaoMySQL.obterConexao().createStatement();
        String sql = "DELETE FROM Cliente WHERE idCliente = " + cli.getIdCliente();
        stmt.execute(sql);
        
    }
        
    
    private List<Cliente> pesquisar(String pesq, int tipo) throws ClassNotFoundException, SQLException {
        
        List<Cliente> lista = new ArrayList();
        
        Statement stmt = ConexaoMySQL.obterConexao().createStatement();
        String sql = "SELECT * FROM Cliente as cli, Endereco as end, Cidade as cid "
                + "WHERE cli.idCliente = end.idEndereco "
                + "AND cli.idCidade = cid.idCidade ";
        switch ( tipo) {
            case 1: sql = sql + "AND cli.nome LIKE '" + pesq + "%'   "; break;
            case 2: sql = sql + "AND cpf = '" + pesq + "'   "; break;
            case 3: sql = sql + "AND bairro LIKE '" + pesq + "%'   "; break;
            case 4: sql = sql + "AND MONTH(dtNasc) = '" + pesq + "'   "; break;
        }
        
        ResultSet rs = stmt.executeQuery(sql);
        while ( rs.next() ) {
            Cidade cid = new Cidade( rs.getInt("idCidade"), rs.getString("cid.nome") );
            Cliente cli = new Cliente( rs.getInt("idCliente"), rs.getString("cli.nome"), rs.getString("cpf"), 
                rs.getDate("dtNasc"), rs.getString("sexo").charAt(0), rs.getInt("idEndereco"), rs.getString("cep"),
                rs.getString("logradouro"), rs.getInt("numero"), rs.getString("complemento"),
                rs.getString("bairro"), rs.getString("referencia"), rs.getString("telefone"),
                rs.getString("celular"), rs.getString("email"), rs.getBytes("foto"),
                cid );
            lista.add(cli);
        }
        return lista;
        
    }
    
    public List<Cliente> listar() throws ClassNotFoundException, SQLException {        
        return pesquisar("", 0);     
    }
    
    public List<Cliente> pesquisarPorNome(String pesq) throws ClassNotFoundException, SQLException {
        return pesquisar(pesq, 1);
    }
    
    public List<Cliente> pesquisarPorCPF(String pesq) throws ClassNotFoundException, SQLException {
        return pesquisar(pesq, 2);
    }
    
    public List<Cliente> pesquisarPorBairro(String pesq) throws ClassNotFoundException, SQLException {
        return pesquisar(pesq, 3);
    }
    
    public List<Cliente> pesquisarPorMes(String pesq) throws ClassNotFoundException, SQLException {
        return pesquisar(pesq, 4);
    }
}

