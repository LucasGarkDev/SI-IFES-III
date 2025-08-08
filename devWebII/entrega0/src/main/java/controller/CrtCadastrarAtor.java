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
    private AplCadastrarAtor getAplicacao(ServletContext context) {
        AplCadastrarAtor apl = (AplCadastrarAtor) context.getAttribute("aplAtor");
        if (apl == null) {
            apl = new AplCadastrarAtor();
            context.setAttribute("aplAtor", apl);
        }
        return apl;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AplCadastrarAtor aplicacao = getAplicacao(getServletContext());
        String acao = request.getParameter("acao");

        if ("alterar".equalsIgnoreCase(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String nome = request.getParameter("nome");
            aplicacao.atualizarAtor(id, nome);
        } else if ("inserir".equalsIgnoreCase(acao)) {
            String nome = request.getParameter("nome");
            aplicacao.adicionarAtor(nome);
        }

        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AplCadastrarAtor aplicacao = getAplicacao(getServletContext());
        String acao = request.getParameter("acao");

        if ("excluir".equalsIgnoreCase(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            aplicacao.removerAtor(id);
            response.sendRedirect("index.jsp");
        } else {
            List<Ator> lista = aplicacao.listarAtores();
            request.setAttribute("listaAtores", lista);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
    }
}
