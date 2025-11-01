// src/config/modules.js

import { atoresArray } from "../../assets/database/atores";
import { classesArray } from "../../assets/database/classes";
import { diretoresArray } from "../../assets/database/diretores";
import { titulosArray } from "../../assets/database/titulos";
import { itensArray } from "../../assets/database/itens";
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
      "Este caso de uso é responsável pelo controle de atores, abrangendo a inclusão de um novo ator, alteração e exclusão.",
    data: filtrarCampos(excludeFields, atoresArray),
    databaseSchema: { nome: "Arnold Schwarzenegger" },
  },
  {
    name: "classes",
    label: "Classes",
    description:
      "Este caso de uso é responsável pelo controle de classes, abrangendo a inclusão de uma nova classe, alteração e exclusão.",
    data: filtrarCampos(excludeFields, classesArray),
    databaseSchema: {
      nome: "Lançamento",
      dataDevolucao: "25-10-2025",
      preco_diaria_centavos: 0.4,
    },
  },
  {
    name: "diretores",
    label: "Diretores",
    description:
      "Este caso de uso é responsável pelo controle de diretores, abrangendo a inclusão de um novo ator, alteração e exclusão.",
    data: filtrarCampos(excludeFields, diretoresArray),
    databaseSchema: {
      nome: "Arnold Schwarzenegger",
      nacionalidade: "Califórnia",
      data_nascimento: "30-07-1947",
    },
  },
  {
    name: "itens",
    label: "Itens",
    description:
      "Este caso de uso é responsável pelo controle de itens (fitas ouDVDs), abrangendo a inclusão, alteração, consulta e exclusão de itens.",
    data: filtrarCampos(excludeFields, itensArray),
    databaseSchema: {
      id: 0,
      numSerie: 41047854527,
      // vem da tabela titulos
      titulo: ["Terminator 2"],
      dtAquisicao: "30-08-1991",
      tipoItem: "DVD",
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
      // vem da tabela ator
      diretor: "James Cameron",
      // vem da tabela diretor
      atores: [
        "Arnold Schwarzenegger",
        "Linda Hamilton",
        "Edward Furlong",
        "Robert Patrick",
      ],
      sinopse:
        "O jovem John Connor é a chave para a vitória da humanidade sobre a rebelião das máquinas no futuro. O garoto é alvo de T-1000, um exterminador feito de metal líquido que pode assumir a forma que desejar e que foi enviado do futuro para matá-lo. Outro exterminador, o renovado T-800, também é mandado de volta para proteger o menino. Enquanto John e sua mãe, Sarah Connor, fogem com o T-800, o garoto cria um vínculo afetivo inesperado com o robô.",
      ano: 1991,
      categoria: "ficção científica",
    },
  },
];

export default modules;
