import api from "./api";

export const getDiretores = () => api.get("/api/diretores");
export const createDiretor = (diretor) => api.post("/api/diretores", diretor);
export const updateDiretor = (id, diretor) => api.put(`/api/diretores/${id}`, diretor);
export const deleteDiretor = (id) => api.delete(`/api/diretores/${id}`);
