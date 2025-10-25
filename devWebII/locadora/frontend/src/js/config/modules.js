// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";
import { filtrarCampos } from "../utils";
const excludeFields = [
  "ativo",
  "data_nascimento",
  "nacionalidade",
  "Nacionalidade",
];

const modules = [
  {
    name: "atores",
    label: "Atores",
    description: "Provavelmente e um ator que faz parte de um filme.",
    data: filtrarCampos(excludeFields, atoresArray),
    databaseSchema: { Nome: "" },
  },
  {
    name: "classes",
    label: "Classes",
    description: null,
    data: filtrarCampos(excludeFields, classesArray),
    databaseSchema: {
      nome: "",
      dataDevolucao: "25/10/2025",
      preco_diaria_centavos: 0.4,
    },
  },
  {
    name: "diretores",
    label: "Diretores",
    description: "Provavelmente e alguem que esta dirigindo ou produzindo um filme.",
    data: filtrarCampos(excludeFields, diretoresArray),
    databaseSchema: {
      nome: "Arnold Schwarzenegger",
      nacionalidade: "Califórnia",
      data_nascimento: "30-07-1947",
    },
  },
];

export default modules;
