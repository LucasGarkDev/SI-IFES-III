// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";
import { filtrarCampos } from "../utils";
const excludeFields = [
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
  },
  {
    name: "diretores",
    label: "Diretores",
    data: filtrarCampos(excludeFields,diretoresArray),
  },
];

export default modules;
