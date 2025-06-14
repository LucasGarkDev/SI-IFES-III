const filmesMock = {
  lancamentos: [
    {
      titulo: "Oppenheimer",
      imagem: "https://image.tmdb.org/t/p/w500/iNpz2DgTsTMPaDRZq2tnbqjLqPp.jpg"
    },
    {
      titulo: "Wonka",
      imagem: "./src/img/lancamentos/Wonka.jpg"
    },
  ],
  acao: [
    {
      titulo: "Missão Impossível",
      imagem: "https://image.tmdb.org/t/p/w500/NNxYkU70HPurnNCSiCjYAmacwm.jpg"
    },
    {
      titulo: "John Wick 4",
      imagem: "https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
    },
  ],
  comedia: [
    {
      titulo: "Gato de Botas 2",
      imagem: "https://image.tmdb.org/t/p/w500/1NqwE6LP9IEdOZ57NCT51ftHtWT.jpg"
    },
    {
      titulo: "As Marvels",
      imagem: "https://image.tmdb.org/t/p/w500/rULWuutDcN5NvtiZi4FRPzRYWSh.jpg"
    },
  ],
};

function renderCards(lista, containerId) {
  const container = document.getElementById(containerId);
  lista.forEach((filme) => {
    const col = document.createElement("div");
    col.className = "col-8 col-sm-6 col-md-4 col-lg-3 col-xl-2 mb-3";

    col.innerHTML = `
      <div class="card bg-dark text-light border-0 h-100">
        <img src="${filme.imagem}" class="card-img-top" alt="${filme.titulo}">
        <div class="card-body p-2">
          <h6 class="card-title mb-0 text-truncate">${filme.titulo}</h6>
        </div>
      </div>
    `;

    container.appendChild(col);
  });
}

// Carregar automaticamente ao iniciar
document.addEventListener("DOMContentLoaded", () => {
  renderCards(filmesMock.lancamentos, "secao-lancamentos");
  renderCards(filmesMock.acao, "secao-acao");
  renderCards(filmesMock.comedia, "secao-comedia");
});
