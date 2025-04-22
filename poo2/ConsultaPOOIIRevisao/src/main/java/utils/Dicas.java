/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author lucas
 */
public class Dicas {
    /**
 * ========================================
 * TUTORIAL: Como adaptar uma nova entidade
 * utilizando GenericDAO e GenericTableModel
 * ========================================
 * 
 * 1. CRIE A ENTIDADE (domain)
 * ----------------------------------------
 * - Crie uma classe simples no pacote `domain` com atributos e métodos getters/setters.
 * - O primeiro atributo da classe deve ser a chave primária (ex: `idCliente`, `idFuncionario`, etc.)
 * - Se houver relacionamento (ex: Cliente possui Cidade), use o tipo da outra classe como campo.
 * 
 *   Exemplo:
 *   public class Cliente {
 *       private int idCliente;
 *       private String nome;
 *       private Cidade cidade;
 *       // Getters e Setters
 *   }
 * 
 * 
 * 2. CRIE O DAO DA ENTIDADE (dao)
 * ----------------------------------------
 * - Crie uma classe `ClienteDAO` que estenda `GenericDAO<Cliente>`.
 * - Passe o nome da tabela e o campo da PK no construtor com `super("Cliente", "idCliente");`
 * - Se a entidade tiver relacionamento com outra, sobrescreva o método `construirObjeto(ResultSet rs)`
 *   para buscar o objeto relacionado (como fizemos no ProdutoDAO com Categoria).
 * 
 *   Exemplo:
 *   public class ClienteDAO extends GenericDAO<Cliente> {
 *       public ClienteDAO() {
 *           super("Cliente", "idCliente");
 *       }
 *
 *       @Override
 *       protected Cliente construirObjeto(ResultSet rs) throws Exception {
 *           Cliente cli = new Cliente();
 *           cli.setIdCliente(rs.getInt("idCliente"));
 *           cli.setNome(rs.getString("nome"));
 *           int idCidade = rs.getInt("idCidade");
 *           Cidade cidade = new CidadeDAO().buscarPorId(idCidade);
 *           cli.setCidade(cidade);
 *           return cli;
 *       }
 *   }
 * 
 * 
 * 3. CRIE O TABLEMODEL (controller/viewer)
 * ----------------------------------------
 * - Use o `GenericTableModel<T>` já pronto.
 * - No JFrame (ou JPanel) da entidade, configure o `JTable` com:
 *     String[] colunas = {"ID", "Nome", "Cidade"};
 *     String[] atributos = {"idCliente", "nome", "cidade.nome"};
 *     GenericTableModel<Cliente> model = new GenericTableModel<>(colunas, atributos);
 *     jTable.setModel(model);
 * - O `GenericTableModel` já resolve atributos aninhados como "cidade.nome".
 * 
 * 
 * 4. USE OS MÉTODOS DO DAO
 * ----------------------------------------
 * - Para salvar: `clienteDAO.inserir(cliente);`
 * - Para alterar: `clienteDAO.alterar(cliente);`
 * - Para buscar: `clienteDAO.buscar(id);`
 * - Para listar: `clienteDAO.listarTodos();`
 * 
 *   Você pode integrar esses métodos ao controlador ou diretamente no JFrame,
 *   de acordo com seu padrão de arquitetura (MVC, MVP etc.).
 * 
 * 
 * 5. CONFERÊNCIA FINAL
 * ----------------------------------------
 * - Certifique-se de que:
 *     ✔ A tabela no banco tem os mesmos nomes de campos da entidade.
 *     ✔ Relacionamentos usam `idEntidade` como coluna (ex: `idCidade`).
 *     ✔ O método sobrescrito `construirObjeto` busca os objetos relacionados.
 *     ✔ O combobox e a tabela são atualizados corretamente.
 * 
 * 
 */

   /*
 * ================================================================
 * 🌟 ROTEIRO DE EXECUÇÃO PARA PROVA PRÁTICA POO2 COM JDBC + SWING
 * ================================================================
 * Cenário: A prova consiste em adaptar um CRUD com interface gráfica
 *          pronta (Swing), utilizando banco de dados e conexão JDBC.
 *          A especificação vem em PDF e o projeto é entregue zipado.
 *
 * Estratégia: Usar o projeto modular já pronto com GenericDAO e 
 *             GenericTableModel, aproveitando os controladores.
 *
 * ================================================================
 * 📦 ETAPA 1 — CONFIGURAÇÃO DO BANCO DE DADOS
 * ================================================================
 *
 * 1. Verifique se o script SQL fornecido é para MySQL ou PostgreSQL:
 *    - estoque_MySQL.sql  → MySQL
 *    - estoque_POSTGRES.sql → PostgreSQL
 *
 * 2. Abra o MySQL Workbench ou pgAdmin, conforme o SGBD escolhido.
 * 3. Crie um novo banco com o nome: estoque
 *    (ou outro nome, se especificado no script).
 * 4. Execute o script `.sql` para criar as tabelas e popular os dados.
 * 5. Confirme visualmente se as tabelas foram criadas corretamente.
 *
 * ================================================================
 * 📦 ETAPA 2 — ABRIR E AJUSTAR O PROJETO
 * ================================================================
 *
 * 6. Extraia o ZIP da prova (deve conter: .java, .form, .sql e .pdf).
 * 7. Abra o projeto no NetBeans ou IntelliJ (Java GUI Builder ativado).
 * 8. Crie os pacotes padrão: `domain`, `dao`, `controller`, `viewer`, `utils`.
 * 9. Copie para o projeto os seguintes arquivos do modelo:
 *    ✅ GenericDAO.java
 *    ✅ GenericTableModel.java
 *    ✅ Util.java
 *    ✅ GerenciadorDominio.java
 *    ✅ GerenciadorInterface.java
 *
 * 10. Copie os arquivos `.form` da prova para `viewer/`
 *     - Ex: TelaPrincipal.form + TelaPrincipal.java
 *
 * ================================================================
 * 🔌 ETAPA 3 — CONFIGURAR CONEXÃO JDBC
 * ================================================================
 *
 * 11. Baixe o driver JDBC:
 *     - MySQL: mysql-connector-java-X.X.X.jar
 *     - PostgreSQL: postgresql-X.X.X.jar
 *
 * 12. Adicione o .jar ao projeto:
 *     - NetBeans: botão direito > Properties > Libraries > Add JAR
 *
 * 13. Edite a classe `Conexao.java` (pacote `controller`) conforme o banco:
 *
 * // Exemplo para MySQL:
 * public class Conexao {
 *     private static final String URL = "jdbc:mysql://localhost:3306/estoque";
 *     private static final String USER = "root";
 *     private static final String PASSWORD = "123456";
 *     public static Connection getConnection() throws SQLException {
 *         return DriverManager.getConnection(URL, USER, PASSWORD);
 *     }
 * }
 *
 * ================================================================
 * 🧱 ETAPA 4 — CRIAR CLASSES DE NEGÓCIO
 * ================================================================
 *
 * 14. Crie as entidades (pacote `domain`), como Produto, Categoria etc.
 *
 * Exemplo:
 * public class Produto {
 *     private int idProduto;
 *     private String nome;
 *     private int quantidade;
 *     private float preco;
 *     private Categoria categoria; // FK
 * }
 *
 * 15. Crie os DAOs, herdando de GenericDAO:
 *
 * public class ProdutoDAO extends GenericDAO<Produto> {
 *     public ProdutoDAO() {
 *         super("Produto", "idProduto");
 *     }
 * }
 *
 * 16. Crie `GerenciadorDominio` e `GerenciadorInterface`
 *     para centralizar a lógica de negócio e a inicialização da interface.
 *
 * ================================================================
 * 🎛️ ETAPA 5 — CONECTAR A INTERFACE GRÁFICA
 * ================================================================
 *
 * 17. Associe os botões `.form` aos seus eventos com o código do projeto.
 *
 * Exemplo:
 * btnInserir.addActionListener(e -> {
 *     Produto p = new Produto();
 *     p.setNome(txtNome.getText());
 *     gerenciador.inserirProduto(p);
 * });
 *
 * 18. Use GenericTableModel para exibir os dados:
 *
 * String[] colunas = {"ID", "Nome", "Quantidade", "Preço", "Categoria"};
 * String[] atributos = {"idProduto", "nome", "quantidade", "preco", "categoria.descricao"};
 * GenericTableModel<Produto> model = new GenericTableModel<>(colunas, atributos);
 * model.setLista(produtoDAO.listarTodos());
 * jTable.setModel(model);
 *
 * ================================================================
 * 📦 ETAPA 6 — VALIDAÇÕES E ENTREGA FINAL
 * ================================================================
 *
 * ✅ Testar todas as operações CRUD: inserir, buscar, alterar, listar.
 * ✅ Validar se ComboBox mostra corretamente o nome da categoria.
 * ✅ Usar métodos Util:
 *    - Util.preencherComboBox(...)
 *    - Util.limparCampos(...)
 *    - Util.converterStringToInt(...)
 *
 * ✅ Adicionar o driver JDBC ao projeto.
 * ✅ Zipe a pasta do projeto com:
 *     - `.java` + `.form`
 *     - Script `.sql`
 *     - PDF da especificação (opcional)
 *     - `README.txt` com instruções
 *
 * ================================================================
 * 💡 DICA FINAL:
 * Leve um pendrive com o projeto modelo já funcional contendo:
 *  ✅ GenericDAO.java
 *  ✅ GenericTableModel.java
 *  ✅ Util.java
 *  ✅ GerenciadorDominio + GerenciadorInterface
 *  ✅ Produto/Categoria implementados como exemplo
 *  ✅ Classe Conexao ajustada para MySQL e PostgreSQL
 *
 * Assim, você apenas adapta as novas entidades e CRUDs exigidos.
 *
 * Boa sorte 🍀 — você está pronto para a prova!
 */

}
