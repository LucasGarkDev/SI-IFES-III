import api from "./api";

export const getTitulos = () => api.get("/api/titulos");
export const createTitulo = (titulo) => api.post("/api/titulos", titulo);
export const updateTitulo = (id, titulo) => api.put(`/api/titulos/${id}`, titulo);
export const deleteTitulo = (id) => api.delete(`/api/titulos/${id}`);
