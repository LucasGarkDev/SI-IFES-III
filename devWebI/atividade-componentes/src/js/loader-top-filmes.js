<<<<<<< HEAD
import { renderIMG, renderA, renderButton } from "./render.js";
window.addEventListener("load", () => {
  const url = "./src/data/top-movies.json";
  const options = {
    method: "GET",
    mode: "cors",
    headers: {
      "content-type": "application/json;charset=utf-8",
    },
  };
=======
import { renderCard } from "./render.js";
>>>>>>> 2d61386 (adiciona renderização dinâmica de filmes e melhorias na interface)

document.addEventListener("DOMContentLoaded", () => {
  fetch("src/data/TopMovies.json")
    .then((res) => {
      if (!res.ok) {
        throw new Error("Erro ao buscar TopMovies.json");
      }
      return res.json();
    })
    .then((data) => {
<<<<<<< HEAD
      console.log("DATA RESPONSE: ");
      console.log(data);
      render(data);
    })
    .catch((error) => onError(error));

  function onError(error) {
    alert(error);
    console.debug(error);
  }
});
=======
      console.log("Filmes carregados:", data);
      const container = document.getElementById("secao-em-alta");

      if (!container) {
        console.error("Elemento #secao-em-alta não encontrado no HTML.");
        return;
      }

      data.forEach((filme) => {
        renderCard(filme, container, filme.id);
      });
    })
    .catch((err) => {
      console.error("Erro ao carregar os filmes:", err);
    });
});

>>>>>>> 2d61386 (adiciona renderização dinâmica de filmes e melhorias na interface)

function render(data) {
  const autoLoadTopFilmes = document.getElementById("autoLoadTopFilmes");
  const autoLoadTopFilmesBtns = document.getElementById(
    "autoLoadTopFilmesBtns"
  );

  renderizarBotoesCarrossel(data, autoLoadTopFilmesBtns);

  renderizarCarrossel(data, autoLoadTopFilmes);
}

// sub funções
function renderizarCarrossel(data, autoLoadTopFilmes) {
  // <div class="carousel-item active">
  // <img src="./src/img/exemplo.png" class="d-block w-100" alt="..." />
  // </div>;
  for (let j = 0; j < data.length; j++) {
    const topFilme = data[j];
    let src = topFilme.image;
    var carrouselItem = document.createElement("div");

    if (!src) {
      src = "./src/img/image-coming-soon.jpg";
    }

    // verifica se e o primeiro elemento e aplica configuracoes personalizadas
    if (j == 0) {
      carrouselItem.setAttribute("class", "carousel-item active");
    } else {
      carrouselItem.setAttribute("class", "carousel-item");
    }

    renderIMG(carrouselItem, "d-block w-100", src, topFilme.fullTitle);

    // adiciona o div carrossel item na lista
    autoLoadTopFilmes.appendChild(carrouselItem);

    console.log(
      `%c [SISTEMA]: Carregado Carrossel image: ${topFilme.fullTitle}`,
      "color: #00ff00"
    );
  }
}
function renderizarBotoesCarrossel(data, autoLoadTopFilmesBtns) {
  // <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
  //   <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
  //   <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  for (let i = 0; i < data.length; i++) {
    var button = document.createElement("button");

    // configurações do botão
    button.setAttribute("type", "button");
    button.setAttribute("data-bs-target", "#carouselExampleIndicators");
    button.setAttribute("data-bs-slide-to", i);
    button.setAttribute("aria-label", `Slide ${i}`);

    // verifica se e o primeiro elemento e aplica configuracoes personalizadas
    if (i == 0) {
      button.setAttribute("class", "active");
      button.setAttribute("aria-current", true);
    }

    // adiciona o button na lista
    autoLoadTopFilmesBtns.appendChild(button);
    console.log(`%c [SISTEMA]: Carregado Botão: ${i}`, "color: #00ff00");
  }
}
