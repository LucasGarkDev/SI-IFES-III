// src/service/apiFunctions.js
import { api } from "./api";
/**
 * Mapeamento de ambientes para URLs
 */
const urls = {
  localhost: "http://localhost:8085/api",
  development2: "",
  production: "https://my-json-server.typicode.com/typicode/demo/",
};

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
 * Wrapper genérico para requisições que lança erro em caso de falha.
 * Detecta automaticamente se o servidor retornou `data` ou `content`.
 * @param {Function} fn Função async do Axios
 * @param  {...any} args Argumentos da função
 * @returns {Promise<any>} Dados retornados da API
 */
async function handleRequest(fn, ...args) {
  try {
    const response = await fn(...args);
    if (!response || typeof response.data !== "object") {
      throw new Error(`Resposta inválida da API: ${response}`);
    }

    const data = response.data;

    // 🔍 Detecta automaticamente qual campo contém o conteúdo principal
    const content =
      data.content ?? // preferência: content
      data.data ?? // fallback: data
      data.result ?? // fallback alternativo: result
      data ?? // se não tiver nada, usa o próprio objeto
      null;

    if (content === null) {
      throw new Error("Nenhum campo de conteúdo encontrado em response.data");
    }

    return content;
  } catch (err) {
    await telemetria(err.message || err.toString());
    throw err; // o componente chamador captura
  }
}

// Funções da API usando o wrapper
export async function getDebug() {
  return handleRequest(api.get, "posts", {
    headers: { Accept: "application/json" },
  });
}

export async function get(endpoint) {
  return handleRequest(api.get, endpoint, {
    headers: { Accept: "application/json" },
  });
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

/**
 * Retorna a URL correspondente ao ambiente
 * @param {string} env - Ambiente selecionado
 * @return {string} URL da API correspondente
 */
export function getUrl(env) {
  return urls[env] || urls.production; // fallback para produção
}
