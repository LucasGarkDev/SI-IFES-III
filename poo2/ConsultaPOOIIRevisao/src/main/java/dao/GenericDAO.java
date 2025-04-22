/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import controller.Conexao;
import domain.Categoria;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import static utils.Util.capitalize;

/**
 *
 * @author lucas
 */
public abstract class GenericDAO<T>{
    private final Class<T> type;
    private final String tableName;
    private final String idField;

    @SuppressWarnings("unchecked")
    public GenericDAO(String tableName, String idField) {
        this.type = (Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0];
        this.tableName = tableName;
        this.idField = idField;
    }

    public void inserir(T obj) throws Exception {
        List<String> fields = new ArrayList<>();
        List<Object> values = new ArrayList<>();

        for (Field field : type.getDeclaredFields()) {
            if (field.getName().equals(idField)) continue; // ignora PK
            field.setAccessible(true);

            Object valor = field.get(obj);

            if (!isPrimitiveOrWrapper(field.getType()) && !(valor instanceof String)) {
                fields.add(getFKColumnName(field)); // ex: idCategoria
            } else {
                fields.add(field.getName()); // ex: nome, preco
            }

            values.add(valor);
        }

        String sql = "INSERT INTO " + tableName + " (" + String.join(", ", fields) + ") VALUES (" +
                String.join(", ", Collections.nCopies(fields.size(), "?")) + ")";

        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            for (int i = 0; i < values.size(); i++) {
                stmt.setObject(i + 1, getIdIfNested(values.get(i)));
            }

            stmt.execute();

            // Preencher o ID gerado
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                Field idF = type.getDeclaredField(idField);
                idF.setAccessible(true);
                Object generatedId = rs.getObject(1);
                if (generatedId instanceof BigInteger) {
                    generatedId = ((BigInteger) generatedId).intValue();
                } else if (generatedId instanceof Long) {
                    generatedId = ((Long) generatedId).intValue();
                }

                idF.set(obj, generatedId);

            }
        }
    }
    
    public void alterar(T obj) throws Exception {
        List<String> campos = new ArrayList<>();
        List<Object> valores = new ArrayList<>();
        Object idValor = null;

        for (Field field : type.getDeclaredFields()) {
            field.setAccessible(true);
            if (field.getName().equals(idField)) {
                idValor = field.get(obj); // Armazena o valor da PK
            } else {
                String nomeCampo = isObjetoAninhado(field) ? getFKColumnName(field) : field.getName();
                campos.add(nomeCampo + " = ?");
                valores.add(getIdIfNested(field.get(obj)));
            }
        }

        String sql = "UPDATE " + tableName + " SET " + String.join(", ", campos)
           + " WHERE " + idField + " = ?";
        System.out.println("SQL de update: " + sql);
        System.out.println("ID de onde: " + idValor);

        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            for (int i = 0; i < valores.size(); i++) {
                stmt.setObject(i + 1, valores.get(i));
            }

            stmt.setObject(valores.size() + 1, idValor); // ID no final

            int afetadas = stmt.executeUpdate();
            System.out.println("Linhas alteradas: " + afetadas);
        }
    }

    public void excluir(T obj) throws Exception {
        Field idF = type.getDeclaredField(idField);
        idF.setAccessible(true);
        Object id = idF.get(obj);

        String sql = "DELETE FROM " + tableName + " WHERE " + idField + " = ?";

        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setObject(1, id);
            stmt.execute();
        }
    }

    public T buscar(Object id) throws Exception {
        String sql = "SELECT * FROM " + tableName + " WHERE " + idField + " = ?";

        try (Connection con = Conexao.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return construirObjeto(rs);
            }
        }
        return null;
    }

    public List<T> listarTodos() throws Exception {
        List<T> lista = new ArrayList<>();
        String sql = "SELECT * FROM " + tableName;

        try (Connection con = Conexao.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                lista.add(construirObjeto(rs));
            }
        }
        return lista;
    }

    // Constrói o objeto baseando-se no ResultSet
    protected T construirObjeto(ResultSet rs) throws Exception {
        T obj = type.getDeclaredConstructor().newInstance();

        for (Field field : type.getDeclaredFields()) {
            field.setAccessible(true);
            try {
                Object valor = rs.getObject(field.getName());

                // Verifica se o campo é objeto e tenta instanciar o ID
                if (valor != null && !field.getType().isPrimitive() && !field.getType().equals(String.class)
                        && !Number.class.isAssignableFrom(field.getType()) && !field.getType().isEnum()) {

                    if (field.getType().equals(Categoria.class)) {
                        CategoriaDAO categoriaDAO = new CategoriaDAO();
                        Categoria categoriaCompleta = categoriaDAO.buscar((Integer) valor); // Carrega com descrição
                        field.set(obj, categoriaCompleta);
                    } else {
                        Object subObj = field.getType().getDeclaredConstructor().newInstance();
                        Field idSub = field.getType().getDeclaredFields()[0]; // Assume que o primeiro é ID
                        idSub.setAccessible(true);
                        idSub.set(subObj, valor);
                        field.set(obj, subObj);
                    }

                } else {
                    field.set(obj, valor);
                }

            } catch (SQLException ignored) {}
        }
        return obj;
    }

    private Object getIdIfNested(Object obj) throws Exception {
        if (obj == null) return null;
        if (isPrimitiveOrWrapper(obj.getClass()) || obj instanceof String) return obj;

        // Pega o primeiro campo (espera que seja o ID)
        Field idF = obj.getClass().getDeclaredFields()[0];
        idF.setAccessible(true);
        return idF.get(obj);
    }

    private boolean isPrimitiveOrWrapper(Class<?> clazz) {
        return clazz.isPrimitive() ||
               clazz == Integer.class ||
               clazz == Long.class ||
               clazz == Float.class ||
               clazz == Double.class ||
               clazz == Boolean.class ||
               clazz == Character.class ||
               clazz == Byte.class ||
               clazz == Short.class;
    }
    
    private String getFKColumnName(Field field) {
        return "id" + capitalize(field.getName());
    }
    
    private boolean isObjetoAninhado(Field field) {
        Class<?> tipo = field.getType();
        return !isPrimitiveOrWrapper(tipo) && !tipo.equals(String.class) && !tipo.isEnum();
    }

}
