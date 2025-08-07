/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.application.AplCadastrarAtor;
import model.domain.Ator;

/**
 *
 * @author lucas
 */
public class CrtCadastrarAtor extends HttpServlet {
    private AplCadastrarAtor aplicacao = new AplCadastrarAtor();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        aplicacao.adicionar(nome);
        response.sendRedirect("CrtCadastrarAtor"); // Redireciona para listar
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Ator> lista = aplicacao.listar();
        request.setAttribute("listaAtores", lista);
        RequestDispatcher rd = request.getRequestDispatcher("WEB-INF/ListagemAtores.jsp");
        rd.forward(request, response);
    }
}
