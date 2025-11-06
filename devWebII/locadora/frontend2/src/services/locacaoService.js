// src/services/locacaoService.js
import axios from "axios";

const API_URL = "http://localhost:8085/api/locacoes"; // ✅ coloque o /api aqui

export const getLocacoes = () => axios.get(API_URL);
export const createLocacao = (data) => axios.post(API_URL, data);
export const devolverLocacao = (data) =>
  axios.post(`${API_URL}/devolucao`, data);
export const updateLocacao = (id, data) =>
  axios.put(`${API_URL}/${id}`, data);
export const deleteLocacao = (id) =>
  axios.delete(`${API_URL}/${id}`);
