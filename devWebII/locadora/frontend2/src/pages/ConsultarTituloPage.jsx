// src/pages/ConsultarTituloPage.jsx
import React, { useState, useEffect } from "react";
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

  // 🔥 BUSCAR TODOS OS TÍTULOS AO CARREGAR A PÁGINA
  useEffect(() => {
    async function carregarInicial() {
      const resp = await buscarTitulosPorNome(""); // chama API sem filtro
      setResultados(resp.content || []);
    }
    carregarInicial();
  }, []);

  // 🔎 BUSCA DINÂMICA
  async function handleSearch(texto) {
    // Se o campo estiver vazio → buscar todos
    if (texto.trim() === "") {
      const resp = await buscarTitulosPorNome("");
      setResultados(resp.content || []);
      return;
    }

    // Senão → filtrar por nome
    const resp = await buscarTitulosPorNome(texto);
    setResultados(resp.content || []);
  }

  // 📝 SELECIONAR TÍTULO PARA VER DETALHES
  async function handleSelect(id) {
    const detalhes = await buscarDetalhesTitulo(id);
    setTituloSelecionado(detalhes);
  }

  return (
    <div className="consulta-container" style={{ padding: "20px" }}>
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

      <SearchBar onSearch={handleSearch} />

      <div
        className="consulta-grid"
        style={{
          display: "grid",
          gridTemplateColumns: "65% 35%",
          marginTop: "20px",
          gap: "20px",
        }}
      >
        <TituloList resultados={resultados} onSelect={handleSelect} />

        <div>
          <Poster titulo={tituloSelecionado} />
          <TituloDetalhes titulo={tituloSelecionado} />
        </div>
      </div>
    </div>
  );
}

export default ConsultarTituloPage;
