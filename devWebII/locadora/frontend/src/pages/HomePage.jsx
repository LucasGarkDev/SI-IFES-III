import React, { useEffect, useState } from "react";
import Navbar from "../components/Navbar";
import Banner from "../components/Banner";
import MovieRow from "../components/MovieRow";
import api from "../services/api";

const HomePage = () => {
  const [lancamentos, setLancamentos] = useState([]);
  const [maisLocados, setMaisLocados] = useState([]);

  useEffect(() => {
    // Exemplo de chamadas à API (simuladas por enquanto)
    api.get("/filmes/lancamentos").then((res) => setLancamentos(res.data));
    api.get("/filmes/mais-locados").then((res) => setMaisLocados(res.data));
  }, []);

  return (
    <div className="bg-black min-h-screen text-white">
      <Navbar />
      <Banner />
      <div className="px-6 space-y-8">
        <MovieRow title="Lançamentos" movies={lancamentos} />
        <MovieRow title="Mais Locados" movies={maisLocados} />
      </div>
    </div>
  );
};

export default HomePage;
