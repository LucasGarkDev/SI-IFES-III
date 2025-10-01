// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";

const modules = [
  {
    name: "atores",
    label: "Atores",
    data: atoresArray,
    newPageFields: ["id", "nome", "nacionalidade"], // usado para a criar novas paginas
  },
  {
    name: "classes",
    label: "Classes",
    data: classesArray,
    newPageFields: ["id", "descricao"],
  },
  {
    name: "diretores",
    label: "Diretores",
    data: diretoresArray,
    newPageFields: ["id", "nome", "idade"],
  },
];

export default modules;
