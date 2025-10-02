// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";

const modules = [
  {
    name: "atores",
    label: "Atores",
    data: atoresArray,
  },
  {
    name: "classes",
    label: "Classes",
    data: classesArray,
  },
  {
    name: "diretores",
    label: "Diretores",
    data: diretoresArray,
  },
];

export default modules;
