import { renderCard } from "./render.js";

const API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMDdhMDdkMjg1NmQxZTcxOTAwYmQwM2M4OWZiMWY1YyIsIm5iZiI6MTc1MDAzMjI2NS40ODgsInN1YiI6IjY4NGY1Zjg5ZTljYThhN2IzYzNmZWFlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.CziaLw_iBbFFrkz-g2jvZ62tzEuYNeW9NgtbKONtGxw"; // ou substitua por chave pública
const BASE_URL = "https://api.themoviedb.org/3";
const IMAGE_BASE = "https://image.tmdb.org/t/p/w500";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("secao-lancamentos");

  const url = `${BASE_URL}/movie/popular?language=pt-BR&page=1`;

  fetch(url, {
    headers: {
      Authorization: `Bearer ${API_KEY}`,
      "Content-Type": "application/json;charset=utf-8",
    },
  })
    .then((res) => {
      if (!res.ok) throw new Error("Erro ao acessar API");
      return res.json();
    })
    .then((data) => {
      const filmes = data.results.map(filme => ({
        id: `tmdb-${filme.id}`,
        title: filme.title,
        fullTitle: filme.title,
        image: filme.backdrop_path ? IMAGE_BASE + filme.backdrop_path : "./src/img/image-coming-soon.jpg",
        year: filme.release_date?.split("-")[0] ?? "N/A",
        crew: "TMDB",
        imDbRating: filme.vote_average?.toFixed(1) ?? "N/A",
        imDbRatingCount: filme.vote_count ?? 0,
      }));

      // Renderiza os filmes
      filmes.forEach(filme => renderCard(filme, container, filme.id));

      // Salva no localStorage para backup
      localStorage.setItem("backupFilmesTMDB", JSON.stringify(filmes));

      // Simula download manual do JSON
      const blob = new Blob([JSON.stringify(filmes, null, 2)], { type: "application/json" });
      const urlBlob = URL.createObjectURL(blob);
      const link = document.createElement("a");
      link.href = urlBlob;
      link.download = "filmes-tmdb.json";
      link.click();
      URL.revokeObjectURL(urlBlob);
    })
    .catch(() => {
      console.warn("⚠️ API falhou. Tentando usar backup local.");
      carregarBackup(container);
    });

  atualizarOffcanvas(); // Garante a recuperação da lista salva
});

function carregarBackup(container) {
  const local = localStorage.getItem("backupFilmesTMDB");
  if (local) {
    const filmes = JSON.parse(local);
    filmes.forEach(filme => renderCard(filme, container, filme.id));
  } else {
    // Fallback final: JSON local do projeto
    fetch("./src/data/filmes-tmdb.json")
      .then(res => res.json())
      .then(data => {
        data.forEach(filme => renderCard(filme, container, filme.id));
      })
      .catch(err => console.error("Erro ao carregar JSON local:", err));
  }
}

// ---------------- FILMES SALVOS PARA DEPOIS ----------------
let filmesSalvos = JSON.parse(localStorage.getItem("filmesSalvos")) || [];

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
  if (!lista) return;

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

