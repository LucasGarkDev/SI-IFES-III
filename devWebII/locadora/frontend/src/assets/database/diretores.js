import { dataStore, carregarBanco } from "../../service/api.js";


// Sincronizar apenas o banco necessario
await carregarBanco("diretores");
console.log("[DB CONTROLLER DIRETOR]: ", dataStore);
let diretoresArray = dataStore.diretoresArray; // cria cópia local mutável

if (!diretoresArray || diretoresArray.length === 0) {
  console.log("Usando dados locais para diretores.js");
  diretoresArray = [
    {
      _id: 1,
      nome: "James Cameron",
    },
    {
      _id: 2,
      nome: "William Wisher",
    },
  ];
}

export { diretoresArray };
