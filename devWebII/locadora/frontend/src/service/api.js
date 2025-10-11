// src/service/api.js
import axios from "axios";
import { get } from "./apiFunctions";

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

// ========== INICIALIZAÇÃO ==========
export async function initData() {
  for (const banco of bancos) {
    const varName = `${banco}Array`;
    dataStore[varName] = [];

    window.addAlert(`🔄 Sincronizando dados...`, "info");
    // busca dados inicial (lazy load)
    await get(banco).then((data) => {
      dataStore[varName] = data;
    });
    window.addAlert("✅ Os dados foram sincronizados!", "success");
    console.log(dataStore);
  }
}

export { api,dataStore };