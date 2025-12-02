import axios from "axios";

const RAPID_KEY = "SUA_CHAVE_AQUI"; // coloque sua chave
const RAPID_HOST = "imdb236.p.rapidapi.com";

const api = axios.create({
  baseURL: `https://${RAPID_HOST}`,
  headers: {
    "X-RapidAPI-Key": RAPID_KEY,
    "X-RapidAPI-Host": RAPID_HOST
  }
});

// 1️⃣ Buscar ID do IMDb
export async function buscarImdbId(titulo) {
  try {
    const resp = await api.get(`/api/imdb/search`, {
      params: { query: titulo }
    });

    if (resp.data.results?.length > 0) {
      return resp.data.results[0].id; // pega o primeiro resultado
    }

    return null;
  } catch (err) {
    console.error("Erro ao buscar IMDb ID:", err);
    return null;
  }
}

// 2️⃣ Buscar poster pelo ID
export async function buscarPoster(imdbId) {
  try {
    const resp = await api.get(`/api/imdb/poster/${imdbId}`);
    return resp.data.poster || null;
  } catch (err) {
    console.error("Erro ao buscar poster:", err);
    return null;
  }
}

// 3️⃣ Função completa: busca ID → busca poster
export async function buscarPosterPorTitulo(titulo) {
  const imdbId = await buscarImdbId(titulo);
  if (!imdbId) return null;

  return await buscarPoster(imdbId);
}
