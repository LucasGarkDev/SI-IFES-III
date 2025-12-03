// src/services/posterService.js
import axios from "axios";

const TMDB_KEY = "207a07d2856d1e71900bd03c89fb1f5c";

const api = axios.create({
  baseURL: "https://api.themoviedb.org/3"
});

// 1️⃣ Buscar filme pelo nome
export async function buscarFilmeTmdb(nome, ano) {
  try {
    const resp = await api.get("/search/movie", {
      params: {
        api_key: TMDB_KEY,
        query: nome,
        year: ano
      }
    });

    if (resp.data.results?.length > 0) {
      return resp.data.results[0];
    }

    return null;
  } catch (err) {
    console.error("Erro ao buscar filme TMDB:", err);
    return null;
  }
}

// 2️⃣ Gerar URL de poster
export function gerarUrlPosterTmdb(path) {
  if (!path) return null;
  return `https://image.tmdb.org/t/p/w500${path}`;
}

// 3️⃣ Função principal
export async function buscarPosterPorTitulo(nome, ano) {
  const filme = await buscarFilmeTmdb(nome, ano);
  if (!filme) return null;

  return gerarUrlPosterTmdb(filme.poster_path);
}
