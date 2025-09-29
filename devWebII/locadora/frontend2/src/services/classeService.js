import api from "./api";

export const getClasses = () => api.get("/api/classes");
export const createClasse = (classe) => api.post("/api/classes", classe);
export const updateClasse = (id, classe) => api.put(`/api/classes/${id}`, classe);
export const deleteClasse = (id) => api.delete(`/api/classes/${id}`);
