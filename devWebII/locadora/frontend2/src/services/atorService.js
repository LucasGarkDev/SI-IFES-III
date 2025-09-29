import api from "./api";

export const getAtores = () => api.get("/atores");
export const createAtor = (ator) => api.post("/atores", ator);
export const updateAtor = (id, ator) => api.put(`/atores/${id}`, ator);
export const deleteAtor = (id) => api.delete(`/atores/${id}`);
