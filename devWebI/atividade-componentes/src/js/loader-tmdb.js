import { renderCard } from "./render.js";

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("secao-lancamentos");

  // Carrega diretamente o JSON local com os dados dos filmes
  fetch("./src/data/filmes-tmdb.json")
    .then(res => res.json())
    .then(filmes => {
      filmes.forEach(filme => renderCard(filme, container, filme.id));
    })
    .catch(err => console.error("❌ Erro ao carregar JSON local:", err));

  atualizarOffcanvas(); // Garante a exibição dos filmes salvos para depois
});

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
