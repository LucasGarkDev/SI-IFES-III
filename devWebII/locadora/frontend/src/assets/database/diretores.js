import apiData from "../../service/api.js";

let diretoresArray = apiData.diretoresArray; // cria cópia local mutável

if (!diretoresArray || diretoresArray.length === 0) {
  console.log("Usando dados locais para diretores.js");
  diretoresArray = [
    {
      _id: 1,
      name: "administrador",
    },
    {
      _id: 2,
      name: "teste",
    },
  ];
}

export { diretoresArray };