
package dao;

import controller.Conexao;
import domain.Categoria;
import domain.Produto;
import java.util.List;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author jean_
 */
public class ProdutoDAO extends GenericDAO<Produto> {
          
    public ProdutoDAO() {
        super("Produto", "idProduto");
    }

    /**
     * Lista todos os produtos com quantidade inferior ao limite informado.
     */
    public List<Produto> listarPorEstoque(int limite) throws Exception {
        String sql = "SELECT * FROM Produto WHERE quantidade < ?";
        return executarConsultaPersonalizada(sql, stmt -> stmt.setInt(1, limite));
    }

    /**
     * Lista todos os produtos de uma categoria específica.
     */
    public List<Produto> listarPorCategoria(Categoria categoria) throws Exception {
        String sql = "SELECT * FROM Produto WHERE idCategoria = ?";
        return executarConsultaPersonalizada(sql, stmt -> stmt.setInt(1, categoria.getIdCategoria()));
    }

    /**
     * Consulta personalizada usando lambda para preparar o statement.
     */
    private List<Produto> executarConsultaPersonalizada(String sql, StatementConfigurator config) throws Exception {
        List<Produto> lista = new ArrayList<>();

        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            if (config != null) config.config(stmt);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Produto produto = construirObjeto(rs); // método herdado do GenericDAO
                lista.add(produto);
            }
        }

        return lista;
    }
    
    @Override
    protected Produto construirObjeto(ResultSet rs) throws Exception {
        Produto prod = new Produto();
        prod.setIdProduto(rs.getInt("idProduto"));
        prod.setNome(rs.getString("nome"));
        prod.setQuantidade(rs.getInt("quantidade"));
        prod.setPreco(rs.getFloat("preco"));

        // Reconstrói a categoria com base no ID
        int idCat = rs.getInt("idCategoria");
        Categoria cat = new CategoriaDAO().buscarPorId(idCat);
        prod.setCategoria(cat);

        return prod;
    }
    
     // 👇 Este método é o que permite reuso nos filtros
    public List<Produto> executarQueryPersonalizada(String sql, PreparedStatementConfigurator config) throws Exception {
        List<Produto> lista = new ArrayList<>();
        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            if (config != null) config.configure(stmt);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Produto p = construirObjeto(rs); // método herdado do GenericDAO
                lista.add(p);
            }
        }
        return lista;
    }
    
    @FunctionalInterface
    public interface PreparedStatementConfigurator {
        void configure(PreparedStatement stmt) throws SQLException;
    }


    /**
     * Interface funcional auxiliar para configurar PreparedStatements.
     */
    @FunctionalInterface
    private interface StatementConfigurator {
        void config(PreparedStatement stmt) throws SQLException;
    }
}
