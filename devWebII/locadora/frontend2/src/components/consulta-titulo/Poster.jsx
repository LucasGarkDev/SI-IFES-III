// src/components/consulta-titulo/Poster.jsx
import React, { useEffect, useState } from "react";
import { buscarPosterPorTitulo } from "../../services/posterService";

function Poster({ titulo }) {
  const [poster, setPoster] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    // Se nenhum título estiver selecionado, limpa o poster
    if (!titulo) {
      setPoster(null);
      return;
    }

    let cancelado = false;

    async function loadPoster() {
      setLoading(true);

      const url = await buscarPosterPorTitulo(titulo.nome, titulo.ano);

      if (!cancelado) {
        setPoster(url);
      }

      setLoading(false);
    }

    loadPoster();

    return () => {
      cancelado = true;
    };
  }, [titulo]);

  return (
    <div
      style={{
        textAlign: "center",
        background: "#222",
        padding: "20px",
        borderRadius: "8px",
        minHeight: "420px",
        display: "flex",
        alignItems: "center",
        justifyContent: "center"
      }}
    >
      {loading ? (
        <p style={{ color: "#bbb" }}>Carregando poster...</p>
      ) : poster ? (
        <img
          src={poster}
          alt={titulo?.nome}
          style={{
            width: "100%",
            maxHeight: "500px",
            objectFit: "contain",
            borderRadius: "8px",
            boxShadow: "0 0 12px rgba(0,0,0,0.4)"
          }}
        />
      ) : (
        <p style={{ color: "#bbb" }}>Poster do Filme</p>
      )}
    </div>
  );
}

export default Poster;
