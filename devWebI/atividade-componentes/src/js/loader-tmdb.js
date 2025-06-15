// src/js/loader-tmdb.js
import { renderCard } from "./render.js";

const API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwN2Y1MzdmYmMxOGEzZGJmODIwNmExZTE3MWVlM2RlMiIsIm5iZiI6MTc0OTg0MjQ4Ny43NjksInN1YiI6IjY4NGM3YTM3N2NkNzNiMDk2ODVjNzY0YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.V9VcipWd5LhSOzQKgMJBGNBcnLwK-G57o16Gi0tLB10";
const BASE_URL = "https://api.themoviedb.org/3";
const IMAGE_BASE = "https://image.tmdb.org/t/p/w500";

document.addEventListener("DOMContentLoaded", () => {
    carregarSecao("movie/popular", "secao-lancamentos"); // 🎬 Lançamentos
    carregarSecao("trending/movie/week", "secao-trending"); // 🔥 Em Alta
    carregarSecao("movie/top_rated", "secao-toprated"); // 🏆 Melhores Avaliados
    carregarSecao("movie/upcoming", "secao-upcoming"); // 📅 Em Breve
});

function carregarFilmes(filmes, container) {
  filmes.forEach((filme) => {
    const cardData = {
      id: `tmdb-${filme.id}`,
      title: filme.title,
      fullTitle: filme.title,
      image: filme.backdrop_path
        ? IMAGE_BASE + filme.backdrop_path
        : "./src/img/image-coming-soon.jpg",
      year: filme.release_date?.split("-")[0] ?? "N/A",
      crew: "TMDB",
      imDbRating: filme.vote_average?.toFixed(1) ?? "N/A",
      imDbRatingCount: filme.vote_count ?? 0,
    };

    renderCard(cardData, container, cardData.id);
  });
}

function carregarSecao(endpoint, containerId) {
  const url = `${BASE_URL}/${endpoint}?language=pt-BR&page=1`;

  fetch(url, {
    headers: {
      Authorization: `Bearer ${API_KEY}`,
      "Content-Type": "application/json;charset=utf-8",
    },
  })
    .then((res) => res.json())
    .then((data) => {
      console.log(`[TMDB] Dados de ${endpoint} carregados:`, data);
      const container = document.getElementById(containerId);
      carregarFilmes(data.results, container);
    })
    .catch((error) =>
      console.error(`Erro ao carregar dados de ${endpoint}:`, error)
    );
}


// Armazena localmente
let filmesSalvos = JSON.parse(localStorage.getItem("filmesSalvos")) || [];

// Evento para capturar cliques
document.addEventListener("click", (event) => {
  const botao = event.target.closest(".salvar-depois");
  if (!botao) return;

  const filme = JSON.parse(botao.dataset.filme);
  if (!filmesSalvos.some(f => f.id === filme.id)) {
    filmesSalvos.push(filme);
    localStorage.setItem("filmesSalvos", JSON.stringify(filmesSalvos));
    alert(`✅ "${filme.title}" salvo para depois!`);
    atualizarOffcanvas();
  } else {
    alert(`ℹ️ "${filme.title}" já está na sua lista.`);
  }
});

function atualizarOffcanvas() {
  const lista = document.getElementById("lista-salvos");
  lista.innerHTML = "";

  if (filmesSalvos.length === 0) {
    lista.innerHTML = "<p class='text-muted'>Nenhum filme salvo ainda.</p>";
    return;
  }

  filmesSalvos.forEach((filme) => {
    const card = document.createElement("div");
    card.className = "d-flex align-items-center mb-3";

    card.innerHTML = `
      <img src="${filme.image}" alt="${filme.title}" width="60" class="rounded me-3" />
      <div>
        <h6 class="mb-0">${filme.title}</h6>
        <small class="text-muted">${filme.year} • IMDb ${filme.imDbRating}</small>
      </div>
    `;

    lista.appendChild(card);
  });
}

document.addEventListener("DOMContentLoaded", atualizarOffcanvas);