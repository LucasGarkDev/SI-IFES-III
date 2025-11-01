import { dataStore, carregarBanco } from "../../service/api.js";

// Sincronizar apenas o banco necessario
await carregarBanco("titulos");
console.log("[DB CONTROLLER TITULOS]: ", dataStore);
let titulosArray = dataStore.titulosArray; // cria cópia local mutável

if (!titulosArray || titulosArray.length === 0) {
  console.log("Usando dados locais para titulos.js");
  titulosArray = [
    {
      nome: "Terminator 2",
      diretor: "James Cameron",
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
    {
      nome: "Terminator",
      diretor: "James Cameron",
      atores: [
        "Michael Biehn",
        "Lance Henriksen",
        "Paul Winfield",
        "Arnold Schwarzenegger",
        "Linda Hamilton",
      ],
      sinopse:
        "Disfarçado de humano, o assassino conhecido como o Exterminador viaja de 2029 a 1984 para matar Sarah Connor. Enviado para proteger Sarah está Kyle Reese, que divulga a chegada do Skynet, um sistema de inteligência artificial que detonará um holocausto nuclear. Sarah é o alvo porque a Skynet sabe que seu futuro filho comandará a luta contra eles. Com o implacável Exterminador os perseguindo, Sarah e Kyle tentam sobreviver.",
      ano: 1985,
      categoria: "ficção científica",
    },
  ];
}

export { titulosArray };
