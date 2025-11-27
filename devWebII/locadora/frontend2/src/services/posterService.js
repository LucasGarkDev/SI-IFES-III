import axios from "axios";

const API_KEY = "SUA_API_KEY_AQUI"; // substitua pela sua chave

export async function buscarPoster(nome, ano) {
  try {
    const resp = await axios.get("https://www.omdbapi.com/", {
      params: {
        apikey: API_KEY,
        t: nome,
        y: ano
      }
    });

    if (resp.data && resp.data.Poster && resp.data.Poster !== "N/A") {
      return resp.data.Poster;
    }

    return null;
  } catch (e) {
    console.error("Erro ao buscar poster:", e);
    return null;
  }
}
