import { data } from "react-router-dom";
import {dataStore} from "../../service/api.js";

console.log("[DB CONTROLLER CLASSES]: ", dataStore);

let classesArray = dataStore.classesArray; // cria cópia local mutável
// if (!classesArray || classesArray.length === 0) {
//   console.log("Usando dados locais para classes.js");
//   classesArray = [
//     {
//       _id: 1,
//       nome: "lancamento",
//       valor: 5.0,
//       dataDevolucao: "01/10/2025",
//     },
//     {
//       _id: 2,
//       nome: "comum",
//       valor: 3.0,
//       dataDevolucao: "02/10/2025",
//     },
//   ];
// }

export { classesArray };