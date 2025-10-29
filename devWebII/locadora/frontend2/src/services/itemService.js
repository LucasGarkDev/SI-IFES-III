import api from "./api";

export const getItens = () => api.get("/api/itens");
export const createItem = (item) => api.post("/api/itens", item);
export const updateItem = (id, item) => api.put(`/api/itens/${id}`, item);
export const deleteItem = (id) => api.delete(`/api/itens/${id}`);
