import apiData from "../../service/api.js";

let classesArray = apiData.classesArray; // cria cópia local mutável
if (!classesArray || classesArray.length === 0) {
  console.log("Usando dados locais para classes.js");
  classesArray = [
    {
      _id: 1,
      name: "maiores de 18",
    },
    {
      _id: 2,
      name: "menores de 18",
    },
  ];
}

export { classesArray };