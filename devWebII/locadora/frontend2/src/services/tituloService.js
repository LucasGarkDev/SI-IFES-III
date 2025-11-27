// src/services/tituloService.js
import api from "./api";

// ==============================
// CONSULTA (NOVA HOME)
// ==============================

// 🔍 Busca leve por nome OU retorna todos se nome = ""
export const buscarTitulosPorNome = async (nome) => {
  const resp = await api.get("/api/titulos/pesquisa", {
    params: { nome }
  });

  return resp.data;
};

// 📘 Detalhes completos do título
export const buscarDetalhesTitulo = async (id) => {
  const resp = await api.get(`/api/titulos/${id}/detalhes`);
  return resp.data;
};

// ==============================
// CRUD (Área do Administrador)
// ==============================

export const getTitulos = () => api.get("/api/titulos");
export const createTitulo = (titulo) => api.post("/api/titulos", titulo);
export const updateTitulo = (id, titulo) => api.put(`/api/titulos/${id}`, titulo);
export const deleteTitulo = (id) => api.delete(`/api/titulos/${id}`);
