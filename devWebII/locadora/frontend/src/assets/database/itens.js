import { dataStore, carregarBanco } from "../../service/api.js";

// Sincronizar apenas o banco necessario
await carregarBanco("itens");
console.log("[DB CONTROLLER ITENS]: ", dataStore);
let itensArray = dataStore.itensArray; // cria cópia local mutável

if (!itensArray || itensArray.length === 0) {
  console.log("Usando dados locais para titulos.js");
  itensArray = [
    {
      numSerie: 41047854527,
      titulo: "Terminator 2",
      data_aquisicao: "30-08-1991",
      tipo: "DVD",
    },
    {
      numSerie: 410478542343,
      titulo: "Terminator ",
      data_aquisicao: "25-03-1985",
      tipo: "DVD",
    },
  ];
}

export { itensArray };
