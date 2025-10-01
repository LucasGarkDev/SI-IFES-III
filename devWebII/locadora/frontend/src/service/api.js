// src/service/api.js
import axios from "axios";

const { VITE_ENV } = import.meta.env;
const url = VITE_ENV === "development" ? "http://localhost:3001/api" : "/api";

// 👇 Bancos que você quer carregar
const bancos = ["atores", "classes", "diretores"];

// 🗃 Data store
const dataStore = {};

// Busca dados da API
async function get(endpoint) {
  try {
    const response = await axios.get(`${url}/${endpoint}`, {
      headers: { Accept: "application/json" },
    });

    if (typeof response.data !== "object") {
      throw new Error(`Resposta inválida da API: ${response.data}`);
    }

    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return []; // ⚠️ retorna array vazio
  }
}

// Envia telemetria
async function telemetria(error) {
  try {
    await axios.post(`${url}/telemetria`, {
      mensagem: "Erro ao buscar dados da API",
      erro: error,
      timestamp: new Date().toISOString(),
    });
  } catch (err) {
    console.error("Erro ao enviar telemetria:", err.message);
  }
}

// Inicializa os dados (lazy)
for (const banco of bancos) {
  const varName = `${banco}Array`;
  dataStore[varName] = [];

  // busca dados da API (sem await aqui)
  get(banco).then((data) => {
    dataStore[varName] = data;
  });
}

export async function initData() {
  await Promise.all(
    bancos.map(async (banco) => {
      const varName = `${banco}Array`;
      const data = await get(banco);
      dataStore[varName] = data;
    })
  );
}

export default dataStore;
