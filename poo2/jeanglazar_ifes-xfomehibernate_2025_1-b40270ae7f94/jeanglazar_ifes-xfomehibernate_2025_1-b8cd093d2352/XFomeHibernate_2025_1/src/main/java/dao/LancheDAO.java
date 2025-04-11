/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import domain.Cidade;
import domain.Lanche;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author 1547816
 */
public class LancheDAO {
    
    public List<Lanche> listar() throws ClassNotFoundException, SQLException {
        
        List<Lanche> lista = new ArrayList();
        
        Statement stmt = ConexaoMySQL.obterConexao().createStatement();
        
        String sql = "SELECT * FROM Lanche";
        
        ResultSet rs = stmt.executeQuery(sql);
        
        // Criar uma LISTA DE OBJETOS
        while ( rs.next() ) {
            Lanche cid = new Lanche(  rs.getInt("idLanche")  , rs.getString("nome") ,
                    rs.getFloat("valor"), rs.getString("ingredientes") );
            lista.add(cid);                        
        }
        
        return lista;
    }
}
