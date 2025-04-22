
package dao;

import controller.Conexao;
import domain.Categoria;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author jean_
 */
public class CategoriaDAO extends GenericDAO<Categoria> {
          
   
    public CategoriaDAO() {
        super("Categoria", "idCategoria");
    }

    public Categoria buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM Categoria WHERE idCategoria = ?";
        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Categoria cat = new Categoria();
                cat.setIdCategoria(rs.getInt("idCategoria"));
                cat.setDescricao(rs.getString("descricao"));
                return cat;
            }
        }
        return null;
    }

}
