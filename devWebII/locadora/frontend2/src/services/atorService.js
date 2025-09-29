import api from "./api";

export const getAtores = () => api.get("/api/atores");
export const createAtor = (ator) => api.post("/api/atores", ator);
export const updateAtor = (id, ator) => api.put(`/api/atores/${id}`, ator);
export const deleteAtor = (id) => api.delete(`/api/atores/${id}`);
