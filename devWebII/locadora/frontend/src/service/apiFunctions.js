// src/service/apiFunctions.js
import { api, productionAPI } from "./api";
const { VITE_BACKEND_PORT, VITE_BACKEND_DOMAIN, VITE_PRODUCTION_URL } = import.meta.env;
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

    // Se não tem resposta, erro
    if (!response) {
      throw new Error(`Resposta inválida da API: ${response}`);
    }

    // Se não tem conteúdo no response.data, pode ser válido para DELETE
    if (response.status === 204) {
      return null; // sucesso sem conteúdo
    }

    // Agora verifica se response.data é objeto, pode aceitar vazio
    if (
      response.data === undefined ||
      response.data === null ||
      typeof response.data !== "object"
    ) {
      throw new Error(
        `Resposta inválida da API: ${JSON.stringify(response.data)}`
      );
    }

    const data = response.data;

    const content = data.content ?? data.data ?? data.result ?? data ?? null;

    if (content === null) {
      throw new Error("Nenhum campo de conteúdo encontrado em response.data");
    }

    return content;
  } catch (err) {
    await telemetria(err.message || err.toString());
    throw err;
  }
}

// Funções da API usando o wrapper
export async function getDebug() {
  return handleRequest(productionAPI.get, "posts", {
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
 * Chama window.addAlert se estiver definido.
 * @param {string} mensagem - Mensagem a exibir
 * @param {string} tipo - Tipo do alerta ("info", "success", "warning", "error")
 */
export function safeApiAlert(mensagem, tipo = "info") {
  if (typeof window.addAlert === "function") {
    window.addAlert(mensagem, tipo);
  } else {
    console.warn(`[ALERTA] ${tipo.toUpperCase()}: ${mensagem}`);
  }
}

/**
 * Retorna a URL correspondente ao ambiente
 * @param {string} type - Ambiente selecionado
 * @return {string} URL da API correspondente
 */
export function getUrl(type) {
  if (type && type == "local"){
    return `http://${VITE_BACKEND_DOMAIN}:${VITE_BACKEND_PORT}/api`
  }
  return VITE_PRODUCTION_URL;
}
