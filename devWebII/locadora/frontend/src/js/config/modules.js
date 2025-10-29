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
    description:
      "Este caso de uso é responsável pelo controle de atores, abrangendoainclusão de um novo ator, alteração e exclusão.",
    data: filtrarCampos(excludeFields, atoresArray),
    databaseSchema: { Nome: "" },
  },
  {
    name: "classes",
    label: "Classes",
    description:
      "Este caso de uso é responsável pelo controle de classes, abrangendoainclusão de uma nova classe, alteração e exclusão.",
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
    description:
      "Este caso de uso é responsável pelo controle de diretores, abrangendoainclusão de um novo ator, alteração e exclusão.",
    data: filtrarCampos(excludeFields, diretoresArray),
    databaseSchema: {
      nome: "Arnold Schwarzenegger",
      nacionalidade: "Califórnia",
      data_nascimento: "30-07-1947",
    },
  },
  {
    name: "item",
    label: "Items",
    description:
      "Este caso de uso é responsável pelo controle de itens (fitas ouDVDs), abrangendo a inclusão, alteração, consulta e exclusão de itens.",
    data: filtrarCampos(excludeFields, itemArray),
    databaseSchema: {
      numero_de_serie: 41047854527,
      titulo: "Califórnia",
      data_aquisicao: "30-07-1947",
      tipo: "DVD"
    },
  },
  {
    name: "titulos",
    label: "Títulos",
    description:
      "Este caso de uso é responsável pelo controle de títulos, abrangendo ainclusãode um novo título, alteração, consulta e exclusão de títulos existentes.",
    data: filtrarCampos(excludeFields, titulosArray),
    databaseSchema: {
      nome: "Terminator 2",
      diretor: "James Cameron",
      atores: [
        "Arnold Schwarzenegger",
        "Linda Hamilton",
        "Edward Furlong",
        "Robert Patrick",
      ],
      sinopse: "O jovem John Connor é a chave para a vitória da humanidade sobre a rebelião das máquinas no futuro. O garoto é alvo de T-1000, um exterminador feito de metal líquido que pode assumir a forma que desejar e que foi enviado do futuro para matá-lo. Outro exterminador, o renovado T-800, também é mandado de volta para proteger o menino. Enquanto John e sua mãe, Sarah Connor, fogem com o T-800, o garoto cria um vínculo afetivo inesperado com o robô.",
      ano: 1991,
      categoria: "ficção científica",
    },
  },
];

export default modules;
