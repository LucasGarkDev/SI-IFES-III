import api from "./api";

export const getDiretores = () => api.get("/diretores");
export const createDiretor = (diretor) => api.post("/diretores", diretor);
export const updateDiretor = (id, diretor) => api.put(`/diretores/${id}`, diretor);
export const deleteDiretor = (id) => api.delete(`/diretores/${id}`);
