// src/service/api.js
import axios from "axios";
import { get, getDebug, getUrl, safeApiAlert } from "./apiFunctions";

// Bancos que você quer carregar
const bancos = ["atores", "classes", "diretores"];

// Cria instância Axios
const api = axios.create({
  baseURL: getUrl("local"),
  timeout: 10000,
  headers: {
    Authorization: `Bearer ${new Date()}`,
    "Content-Type": "application/json",
  },
});

export const productionAPI = axios.create({
  baseURL: getUrl("production"),
  timeout: 10000,
  headers: {
    Authorization: `Bearer ${new Date()}`,
    "Content-Type": "application/json",
  },
});

// Armazena os dados carregados
let dataStore = {};

/**
 * Carrega os dados de um banco, se falhar, usa dados locais.
 * @param {string} banco - Nome do banco
 * @return {Promise<any[]>} - Array de dados
 */
export async function carregarBanco(banco) {
  const varName = `${banco}Array`;
  try {
    safeApiAlert(`🔄 Carregando ${banco} da API...`, "info");
    const data = await get(banco);
    dataStore[varName] = data;
    safeApiAlert(`✅ ${banco} carregado da API!`, "success");
    console.log(`[API] Dados carregados de ${banco}:`, data);
    return data;
  } catch (err) {
    console.warn(
      `[LOCAL] Falha ao carregar ${banco} da API, usando dados APIdemo.`
    );
    const localData = await getDebug(); // fallback para dados locais
    dataStore[varName] = localData;
    safeApiAlert(`⚠️ Usando dados APIdemo para ${banco}`, "warning");
    return localData;
  }
}

/**
 * Inicializa todos os bancos na inicialização do sistema.
 */
export async function inicializarDados() {
  for (const banco of bancos) {
    await carregarBanco(banco);
  }
}

/**
 * Sincroniza os dados dos bancos, com alertas e fallback.
 */
export async function syncData() {
  for (const banco of bancos) {
    const varName = `${banco}Array`;
    safeApiAlert(`🔄 Sincronizando ${banco}...`, "info");

    try {
      const data = await get(banco);
      dataStore[varName] = data;
      safeApiAlert(`✅ ${banco} sincronizado!`, "success");
      console.log(`[SYNC] ${banco} sincronizado:`, data);
    } catch (err) {
      console.warn(
        `[SYNC] Falha ao sincronizar ${banco} da API, usando dados demoAPI.`
      );
      const localData = await getDebug(); // fallback local
      dataStore[varName] = localData;
      console.error(`[SYNC] Erro ao sincronizar ${banco}:`, err);
      safeApiAlert(`❌ Falha ao sincronizar ${banco}`, "error");
    }
  }
}
export { api, dataStore };