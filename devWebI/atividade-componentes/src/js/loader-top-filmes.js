import { renderIMG, renderA, renderButton } from "./render.js";
(() => {
  const url = "./src/data/topMovies.json";
  const options = {
    method: "GET",
    mode: "cors",
    headers: {
      "content-type": "application/json;charset=utf-8",
    },
  };

  fetch(url, options)
    .then((response) => {
      if (response.ok) {
        return response.json();
      } else {
        return response.text().then((errorText) => {
          throw new Error("Falha ao buscar Top Movies: " + errorText);
        });
      }
    })
    .then((data) => {
      console.log("DATA RESPONSE: ");
      console.log(data);
      render(data);
    })
    .catch((error) => onErrorHostname(error));

  function onErrorHostname(error) {
    console.debug(error);
  }
})();

function render(data) {
  const autoLoadTopFilmes = document.getElementById("autoLoadTopFilmes");
  const autoLoadTopFilmesBtns = document.getElementById(
    "autoLoadTopFilmesBtns"
  );

  // <button
  //         type="button"
  //         data-bs-target="#carouselExampleIndicators"
  //         data-bs-slide-to="2"
  //         aria-label="Slide 3"
  //       ></button>
  for (let i = 0; i < data.length; i++) {
    var button = document.createElement("button");

    // configurações do botão
    button.setAttribute("type", "button");
    button.setAttribute("data-bs-target", "#carouselExampleIndicators");
    button.setAttribute("data-bs-slide-to", i);
    button.setAttribute("aria-label", `Slide ${i}`);

    // adiciona o button na lista
    autoLoadTopFilmesBtns.appendChild(button);

    console.log(`%c [SISTEMA]: Carregado Botão: ${i}`, "color: #00ff00");
  }

  // <div class="carousel-item active">
    // <img src="./src/img/exemplo.png" class="d-block w-100" alt="..." />
  // </div>;
  for (let j = 0; j < data.length; j++) {
    const topFilme = data[j];
    var carrouselItem = document.createElement("div");

    if (j == 0) {
      carrouselItem.setAttribute("class", "carousel-item active");
    } else {
      carrouselItem.setAttribute("class", "carousel-item");
    }

    renderIMG(carrouselItem,"d-block w-100", topFilme.image, topFilme.fullTitle);

    // adiciona o div carrossel item na lista
    autoLoadTopFilmes.appendChild(carrouselItem);

    console.log(
      `%c [SISTEMA]: Carregado Carrossel image: ${topFilme.fullTitle}`,
      "color: #00ff00"
    );
  }
}
