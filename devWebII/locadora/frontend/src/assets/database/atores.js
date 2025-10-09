import {dataStore} from "../../service/api.js";

console.log("[DB CONTROLLER ATORES]: ", dataStore);
let atoresArray = dataStore.atoresArray; // cria cópia local mutável
// if (!atoresArray || atoresArray.length === 0) {
//   console.log("Usando dados locais para atores.js");
//   atoresArray = [
//     {
//       _id: 1,
//       name: "ator 1",
//       nacionalidade: "brasileiro",
//     },
//     {
//       _id: 2,
//       name: "ator 2",
//       nacionalidade: "americano",
//     },
//   ];
// }

export { atoresArray };