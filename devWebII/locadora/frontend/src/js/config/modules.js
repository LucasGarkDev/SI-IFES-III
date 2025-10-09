// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";
const excludeFields = [
  "id",
  "_id",
  "ativo",
  "data_nascimento",
  "nacionalidade",
  "Nacionalidade"
];

const modules = [
  {
    name: "atores",
    label: "Atores",
    data: filtrarCampos(excludeFields,atoresArray),
  },
  {
    name: "classes",
    label: "Classes",
    data: filtrarCampos(excludeFields,classesArray),
    excludeFields: [],
  },
  {
    name: "diretores",
    label: "Diretores",
    data: diretoresArray,
    excludeFields: [],
  },
];

export default modules;
