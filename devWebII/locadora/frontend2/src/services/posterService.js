import axios from "axios";

const API_KEY = "38499.u5NLUA-a2Lnfiwmc89XfaJLdmL78xu0bU0UDZVr5JMRoMDAwdTAwMDal_EYqbDqIjiROPCBqYgH6lwT0NxVO4hdGWPDXainyjOIYSZKD5TXxIkbn26nDF9J57THN4QvchvJyvLlpBNYVkaeGWf8AVbD40RLp4Q10arq6EyZH5ScSJUCg92Y9TQ==.yIoRqFDHNIaeFm0ccOMn2cidCe9bochE29in3iTX535oMDAwdTAwMGjed0atZinq4RF27HJgQRJgLuQepNjvUoUXzQBP-e7qg2esb-PUF7nc1TkOOxl7XtOM9sVsEscUB4xh1KS5imMq6xW_UGy-VcoiQ9X6L96HgwgwQnKhR2CNS8gOPADmJQMtv3EgktnAQl8arZ5GPAVMwc21eaFQ2ysEsTdrPmZmiLUH2h6-aqlZ0BpiUvWckPlhR_bn3xSjjzzGwi6cVooz9Guh5jVeNTgsfcvaZoULu6IwX2cdEB1IwkZpHzlXHAksj4q2R9bkVwuQprYkN6UaML6nxAXSV0FtjJbBo_lBrTUaywbBIDulx2nYlS1tYo4eseEKz0KEdqWLZ-L8Y4yHv0rI9NYmpISn6z1Gc1ZO7Lc_YJEBiwVuovEsHloNxlocjxMZRDIXaX6j8dH3Vc8GR6H_8oqw7MIHVbtItYQE"; // substitua pela sua chave

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
