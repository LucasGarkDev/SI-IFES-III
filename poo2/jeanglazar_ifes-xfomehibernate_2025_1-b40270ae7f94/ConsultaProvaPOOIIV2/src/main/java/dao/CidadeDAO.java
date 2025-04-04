/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import domain.Cidade;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author 1547816
 */
public class CidadeDAO {
    
    public List<Cidade> listar() throws ClassNotFoundException, SQLException {
        
        List<Cidade> lista = new ArrayList();
        
        Statement stmt = ConexaoMySQL.obterConexao().createStatement();
        
        String sql = "SELECT * FROM Cidade";
        
        ResultSet rs = stmt.executeQuery(sql);
        
        // Criar uma LISTA DE OBJETOS
        while ( rs.next() ) {
            Cidade cid = new Cidade(  rs.getInt("idCidade")  , rs.getString("nome")  );
            lista.add(cid);                        
        }
        
        return lista;
    }
    
}
