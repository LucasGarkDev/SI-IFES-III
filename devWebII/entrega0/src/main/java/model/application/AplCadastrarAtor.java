/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.application;

import java.util.ArrayList;
import java.util.List;
import model.domain.Ator;
import org.hibernate.Session;
import org.hibernate.Transaction;
import utils.HibernateUtil;

/**
 *
 * @author lucas
 */
public class AplCadastrarAtor {
    public void adicionarAtor(String nome) {
        if (nome != null && !nome.trim().isEmpty()) {
            Ator ator = new Ator(nome.trim());

            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                Transaction tx = session.beginTransaction();
                session.persist(ator);
                tx.commit();
            }
        }
    }

    public void atualizarAtor(int id, String novoNome) {
        if (novoNome != null && !novoNome.trim().isEmpty()) {
            try (Session session = HibernateUtil.getSessionFactory().openSession()) {
                Transaction tx = session.beginTransaction();
                Ator ator = session.get(Ator.class, id);
                if (ator != null) {
                    ator.setNome(novoNome.trim());
                    session.merge(ator);
                }
                tx.commit();
            }
        }
    }

    public void removerAtor(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Ator ator = session.get(Ator.class, id);
            if (ator != null) {
                session.remove(ator);
            }
            tx.commit();
        }
    }

    public Ator buscarAtor(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Ator.class, id);
        }
    }

    public List<Ator> listarAtores() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from Ator", Ator.class).list();
        }
    }
}
