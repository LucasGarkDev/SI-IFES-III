// src/service/api.js
import axios from "axios";
import { get, getDebug, getUrl, safeApiAlert } from "./apiFunctions";

const bancos = ["atores", "classes", "diretores","titulos","itens"];

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

// Armazena dados carregados
let dataStore = {};

/**
 * Carrega dados do backend para um banco específico.
 * @param {string} banco - Nome do banco
 * @return {Promise<any[]>}
 */
export async function carregarBanco(banco) {
  const varName = `${banco}Array`;
  try {
    safeApiAlert(`🔄 Carregando ${banco} da API...`, "info");
    const data = await get(banco);
    dataStore[varName] = data;
    safeApiAlert(`✅ ${banco} carregado com sucesso!`, "success");
    console.log(`[API] Dados carregados de ${banco}:`, data);
    return data;
  } catch (err) {
    console.warn(`[LOCAL] Falha ao carregar ${banco}, usando demo.`);
    const localData = await getDebug();
    dataStore[varName] = localData;
    safeApiAlert(`⚠️ Usando dados locais para ${banco}`, "warning");
    return localData;
  }
}

/**
 * Inicializa todos os bancos.
 */
export async function inicializarDados() {
  for (const banco of bancos) {
    await carregarBanco(banco);
  }
}

/**
 * 🔁 Sincroniza todos os bancos ou um banco específico.
 * Pode ser usada globalmente ou em módulos isolados.
 * @param {string} [banco] - Se fornecido, sincroniza apenas esse banco.
 * @param {function} [setData] - (Opcional) Atualiza um state React em tempo real.
 */
export async function syncData(banco, setData) {
  // 🔸 Caso use sem parâmetros: sincroniza todos
  if (!banco) {
    for (const b of bancos) {
      await syncData(b);
    }
    return;
  }

  const varName = `${banco}Array`;
  safeApiAlert(`🔁 Sincronizando ${banco}...`, "info");

  try {
    const data = await get(banco);
    dataStore[varName] = data;

    if (typeof setData === "function") {
      setData(data); // 🔥 Atualiza tabela instantaneamente
    }

    safeApiAlert(`✅ ${banco} sincronizado!`, "success");
    console.log(`[SYNC] ${banco} sincronizado:`, data);
  } catch (err) {
    console.warn(`[SYNC] Falha ao sincronizar ${banco}. Usando demo.`);
    const localData = await getDebug();
    dataStore[varName] = localData;

    if (typeof setData === "function") {
      setData(localData);
    }

    safeApiAlert(`❌ Falha ao sincronizar ${banco}`, "error");
  }
}

export { api, dataStore };