import { atoresArray as importedAtoresArray } from "../../service/api.js";

let atoresArray = importedAtoresArray; // cria cópia local mutável

if (!atoresArray || atoresArray.length === 0) {
  console.log("Usando dados locais para atores.js");
  atoresArray = [
    {
      _id: 1,
      name: "Henrique & Juliano",
    },
    {
      _id: 2,
      name: "MC Tuto",
    },
    {
      _id: 3,
      name: "Jorge & Mateus",
    },
    {
      _id: 4,
      name: "NATTAN",
    },
    {
      _id: 5,
      name: "Grupo Menos É Mais",
    },
    {
      _id: 6,
      name: "Zé Neto & Cristiano",
    },
    {
      _id: 7,
      name: "Matheus & Kauan",
    },
    {
      _id: 8,
      name: "Oruam",
    },
    {
      _id: 9,
      name: "Murilo Huff",
    },
    {
      _id: 10,
      name: "Hugo & Guilherme",
    },
    {
      _id: 11,
      name: "MC LUUKY",
    },
    {
      _id: 12,
      name: "Léo Foguete",
    },
    {
      _id: 13,
      name: "Gusttavo Lima",
    },
    {
      _id: 14,
      name: "Nilo",
    },
    {
      _id: 15,
      name: "Luan Pereira",
    },
    {
      _id: 16,
      name: "Guilherme & Benuto",
    },
    {
      _id: 17,
      name: "Marília Mendonça",
    },
    {
      _id: 18,
      name: "Luan Santana",
    },
    {
      _id: 19,
      name: "Gustavo Mioto",
    },
    {
      _id: 20,
      name: "Henry Freitas",
    },
  ];
}

export { atoresArray };