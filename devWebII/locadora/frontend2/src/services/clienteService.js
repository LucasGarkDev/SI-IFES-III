import api from "./api";

export const getClientes = () => api.get("/api/clientes");
export const createSocio = (socio) => api.post("/api/clientes/socio", socio);
export const deleteCliente = (id) => api.delete(`/api/clientes/${id}`);
