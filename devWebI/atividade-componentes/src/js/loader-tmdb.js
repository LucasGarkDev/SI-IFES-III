// src/js/loader-tmdb.js
import { renderCard } from "./render.js";

const API_KEY = "SUA_CHAVE_AQUI"; // ⬅️ Substitua pela sua chave da TMDB
const BASE_URL = "https://api.themoviedb.org/3";
const IMAGE_BASE = "https://image.tmdb.org/t/p/w500";

document.addEventListener("DOMContentLoaded", () => {
  const url = `${BASE_URL}/movie/popular?api_key=${API_KEY}&language=pt-BR&page=1`;

  fetch(url)
    .then((res) => res.json())
    .then((data) => {
      console.log("[TMDB] Filmes populares carregados:", data);
      const container = document.getElementById("secao-lancamentos");
      carregarFilmes(data.results, container);
    })
    .catch((error) => console.error("Erro ao carregar TMDB:", error));
});

function carregarFilmes(filmes, container) {
  filmes.forEach((filme, index) => {
    const cardData = {
      id: `tmdb-${filme.id}`,
      title: filme.title,
      fullTitle: filme.title,
      image: IMAGE_BASE + filme.backdrop_path,
      year: filme.release_date?.split("-")[0] ?? "N/A",
      crew: "TMDB",
      imDbRating: filme.vote_average.toFixed(1),
      imDbRatingCount: filme.vote_count,
    };

    renderCard(cardData, container, cardData.id);
  });
}
