// src/service/apiFunctions.js

import { api } from './api';

/**
 * Funções genéricas para comunicação com API REST usando Axios.
 *
 * @module apiFunctions
 */

/**
 * Busca dados de um endpoint via GET
 * @param {string} endpoint Caminho do recurso (ex: "atores")
 * @returns {Promise<Array|Object>} Conteúdo da resposta ou array vazio em caso de erro
 */
export async function get(endpoint) {
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

/**
 * Cria um novo registro via POST
 * @param {string} endpoint Caminho do recurso
 * @param {Object} payload Dados a serem enviados
 * @returns {Promise<Object|null>} Resposta da API ou null se falhar
 */
export async function create(endpoint, payload) {
  try {
    const response = await api.post(`${endpoint}`, payload);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

/**
 * Atualiza um registro via PUT
 * @param {string} endpoint Caminho do recurso
 * @param {string|number} id ID do item
 * @param {Object} payload Dados atualizados
 * @returns {Promise<Object|null>} Resposta da API ou null se falhar
 */
export async function update(endpoint, id, payload) {
  try {
    const response = await api.put(`${endpoint}/${id}`, payload);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

/**
 * Remove um registro via DELETE
 * @param {string} endpoint Caminho do recurso
 * @param {string|number} id ID do item
 * @returns {Promise<Object|null>} Resposta da API ou null se falhar
 */
export async function remove(endpoint, id) {
  try {
    const response = await api.delete(`${endpoint}/${id}`);
    return response.data;
  } catch (error) {
    await telemetria(error.message || error.toString());
    return null;
  }
}

// ========== TELEMETRIA ==========
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

// example usage

// // buscar
// const atores = await get("atores");

// // criar
// await create("atores", { nome: "Novo Ator", nacionalidade: "Brasileiro" });

// // atualizar
// await update("atores", 1, { nome: "Ator Atualizado" });

// // deletar
// await remove("atores", 1);
