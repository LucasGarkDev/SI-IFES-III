import api from "./api";

export const getLocacoes = () => api.get("/locacoes");
export const createLocacao = (data) => api.post("/locacoes", data);
export const devolverLocacao = (data) => api.post("/locacoes/devolucao", data);
export const cancelarLocacao = (id) => api.delete(`/locacoes/${id}`);
export const updateLocacao = (id, data) => api.put(`/locacoes/${id}`, data);
