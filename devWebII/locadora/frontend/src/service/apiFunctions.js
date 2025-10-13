// src/service/apiFunctions.js
import { api } from './api';

/**
 * Envia telemetria de erro para a API
 * @param {string} error Mensagem de erro
 */
export async function telemetria(error) {
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

/**
 * Wrapper genérico para requisições que lança erro em caso de falha
 * @param {Function} fn Função async do Axios
 * @param  {...any} args Argumentos da função
 * @returns {Promise<any>} Resposta da API
 */
async function handleRequest(fn, ...args) {
  try {
    const response = await fn(...args);
    if (!response || typeof response.data !== 'object') {
      throw new Error(`Resposta inválida da API: ${response}`);
    }
    const data = response.data;
    // servidor usa content para armazenar dados
    return data.content;
  } catch (err) {
    await telemetria(err.message || err.toString());
    throw err; // <--- lança o erro, o componente vai capturar
  }
}

// Funções da API usando o wrapper
export async function get(endpoint) {
  return handleRequest(api.get, endpoint, { headers: { Accept: 'application/json' } });
}

export async function create(endpoint, payload) {
  return handleRequest(api.post, endpoint, payload);
}

export async function update(endpoint, id, payload) {
  return handleRequest(api.put, `${endpoint}/${id}`, payload);
}

export async function remove(endpoint, id) {
  return handleRequest(api.delete, `${endpoint}/${id}`);
}