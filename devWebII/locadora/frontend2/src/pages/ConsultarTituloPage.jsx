// src/pages/ConsultarTituloPage.jsx
import React, { useState } from "react";
import SearchBar from "../components/consulta-titulo/SearchBar";
import TituloList from "../components/consulta-titulo/TituloList";
import Poster from "../components/consulta-titulo/Poster";
import TituloDetalhes from "../components/consulta-titulo/TituloDetalhes";

import { buscarTitulosPorNome, buscarDetalhesTitulo } from "../services/tituloService";
import "../styles/global.css";
import { useNavigate } from "react-router-dom";

function ConsultarTituloPage() {
  const navigate = useNavigate();

  const [resultados, setResultados] = useState([]);
  const [tituloSelecionado, setTituloSelecionado] = useState(null);

  async function handleSearch(texto) {
    if (texto.trim() === "") {
      setResultados([]);
      return;
    }

    const resp = await buscarTitulosPorNome(texto);
    setResultados(resp.content || []);
  }

  async function handleSelect(id) {
    const detalhes = await buscarDetalhesTitulo(id);
    setTituloSelecionado(detalhes);
  }

  return (
    <div className="consulta-container" style={{ padding: "20px" }}>

      {/* Cabeçalho da Nova Home */}
      <div className="consulta-header" style={{ display: "flex", justifyContent: "space-between" }}>
        <h1 style={{ margin: 0 }}>Locadora Passatempo</h1>

        <button
          onClick={() => navigate("/admin")}
          style={{
            backgroundColor: "#444",
            color: "white",
            padding: "8px 16px",
            borderRadius: "5px",
          }}
        >
          Área do Administrador
        </button>
      </div>

      {/* Barra de Busca */}
      <SearchBar onSearch={handleSearch} />

      {/* Grid Principal */}
      <div
        className="consulta-grid"
        style={{
          display: "grid",
          gridTemplateColumns: "65% 35%",
          marginTop: "20px",
          gap: "20px",
        }}
      >
        {/* Lista de Títulos */}
        <TituloList resultados={resultados} onSelect={handleSelect} />

        {/* Painel Direito: Poster + Detalhes */}
        <div>
          <Poster titulo={tituloSelecionado} />
          <TituloDetalhes titulo={tituloSelecionado} />
        </div>
      </div>
    </div>
  );
}

export default ConsultarTituloPage;
