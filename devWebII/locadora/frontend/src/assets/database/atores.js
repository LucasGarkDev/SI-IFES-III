import { carregarBanco, dataStore } from "../../service/api.js";

// Sincronizar apenas "atores"
await carregarBanco("atores");
console.log("[DB CONTROLLER ATORES]: ", dataStore);
let atoresArray = dataStore.atoresArray; // cria cópia local mutável
if (!atoresArray || atoresArray.length === 0) {
  console.log("Usando dados locais para atores.js");
  atoresArray = [
    {
      _id: 1,
      nome: "Linda Hamilton",
    },
    {
      _id: 2,
      nome: "Arnold Schwarzenegger",
    },
    {
      _id: 3,
      nome: "Robert Patrick",
    },
  ];
}

export { atoresArray };
