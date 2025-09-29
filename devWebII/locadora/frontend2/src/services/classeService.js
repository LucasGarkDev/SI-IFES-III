import api from "./api";

export const getClasses = () => api.get("/classes");
export const createClasse = (classe) => api.post("/classes", classe);
export const updateClasse = (id, classe) => api.put(`/classes/${id}`, classe);
export const deleteClasse = (id) => api.delete(`/classes/${id}`);
