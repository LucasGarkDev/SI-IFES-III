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

  // <div class="carousel-item active">
  //   <img src="./src/img/exemplo.png" class="d-block w-100" alt="..." />
  // </div>;
  for (let i = 0; i < data.length; i++) {
    var carouselitem = document.createElement("div");
		var img = document.createElement("img");

    newScriptLib.setAttribute("src", srcsLib[i]);
    autoscripts.appendChild(newScriptLib);

    console.log(`%c [SISTEMA]: Nova Lib: ${srcsLib[i]}`, "color: #ffa500");
  }

	// <button
  //         type="button"
  //         data-bs-target="#carouselExampleIndicators"
  //         data-bs-slide-to="2"
  //         aria-label="Slide 3"
  //       ></button>
  for (let i = 0; i < srcs.length; i++) {
    const src = srcs[i];
    const link = fonte + src + ".js";
    var newScript = document.createElement("script");

    newScript.setAttribute("src", link);
    autoscripts.appendChild(newScript);

    console.log(`%c [SISTEMA]: Carregando script: ${link}`, "color: #ff00ff");
  }
}
