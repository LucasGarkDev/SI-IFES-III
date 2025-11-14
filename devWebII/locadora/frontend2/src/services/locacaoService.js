import api from "./api";

export const getLocacoes = () => api.get("/api/locacoes");
export const createLocacao = (data) => api.post("/api/locacoes", data);
export const devolverLocacao = (data) => api.post("/api/locacoes/devolucao", data);
export const cancelarLocacao = (id) => api.delete(`/api/locacoes/${id}`);
export const updateLocacao = (id, data) => api.put(`/api/locacoes/${id}`, data);
