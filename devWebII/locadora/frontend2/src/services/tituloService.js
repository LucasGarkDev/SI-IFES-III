import api from "./api";

export const getTitulos = () => api.get("/api/titulos");
export const createTitulo = (titulo) => api.post("/api/titulos", titulo);
export const updateTitulo = (id, titulo) => api.put(`/api/titulos/${id}`, titulo);
export const deleteTitulo = (id) => api.delete(`/api/titulos/${id}`);

// ==============================
// Consultar Títulos (Nova Home)
// ==============================

// 🔍 Busca leve por nome
export const searchTitulos = (nome) => api.get(`/api/titulos/search?nome=${nome}`);

// 📘 Detalhes completos do título
export const getTituloDetalhes = (id) => api.get(`/api/titulos/${id}/detalhes`);