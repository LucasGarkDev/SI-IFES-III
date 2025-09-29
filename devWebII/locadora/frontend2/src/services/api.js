import axios from "axios";

const api = axios.create({
  baseURL: "http://localhost:8080", // ajuste se o backend rodar em outra porta
});

export default api;
