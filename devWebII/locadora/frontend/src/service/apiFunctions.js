// src/service/apiFunctions.js
import { api, productionAPI } from "./api";
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
      throw new Error(`Resposta inválida da API: ${JSON.stringify(response.data)}`);
    }

    const data = response.data;

    const content =
      data.content ??
      data.data ??
      data.result ??
      data ??
      null;

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
 * Retorna a URL correspondente ao ambiente
 * @param {string} env - Ambiente selecionado
 * @return {string} URL da API correspondente
 */
export function getUrl(env) {
  return urls[env] || urls.production; // fallback para produção
}
