// src/service/api.js
import axios from "axios";

const { VITE_ENV } = import.meta.env;
const url = VITE_ENV === "development" ? "http://localhost:8085/api" : "/api";

// 👇 Bancos que você quer carregar
const bancos = ["atores", "classes", "diretores"];

const api = axios.create({
  baseURL: url,
  timeout: 10000,
  headers: {
    Authorization: `Bearer ${new Date()}`,
    "Content-Type": "application/json",
  },
});

// 🗃 Data store
let dataStore = {};

// ========== FUNÇÕES GENÉRICAS ==========
async function get(endpoint) {
  try {
    const response = await api.get(`${endpoint}`, {
      headers: { Accept: "application/json" },
    });

    if (typeof response.data !== "object") {
      throw new Error(`Resposta inválida da API: ${response.data}`);
    }

    return response.data.content;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return [];
  }
}

async function create(endpoint, payload) {
  try {
    const response = await api.post(`${endpoint}`, payload);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

async function update(endpoint, id, payload) {
  try {
    const response = await api.put(`${endpoint}/${id}`, payload);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

async function remove(endpoint, id) {
  try {
    const response = await api.delete(`${endpoint}/${id}`);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

// ========== TELEMETRIA ==========
async function telemetria(error) {
  try {
    await api.post(`/telemetria`, {
      mensagem: "Erro ao comunicar com API",
      erro: error,
      timestamp: new Date().toISOString(),
    });
  } catch (err) {
    console.error("Erro ao enviar telemetria:", err.message);
  }
}

// ========== INICIALIZAÇÃO ==========
export async function initData(){

  for (const banco of bancos) {
    const varName = `${banco}Array`;
    dataStore[varName] = [];

    // busca dados inicial (lazy load)
    await get(banco).then((data) => {
      dataStore[varName] = data;
    });
    console.log(dataStore)
  }
}
await initData();

export { get, create, update, remove,dataStore };
// example usage
// import { get, create, update, remove } from "../service/api";

// // buscar
// const atores = await get("atores");

// // criar
// await create("atores", { nome: "Novo Ator", nacionalidade: "Brasileiro" });

// // atualizar
// await update("atores", 1, { nome: "Ator Atualizado" });

// // deletar
// await remove("atores", 1);
