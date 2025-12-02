// src/components/consulta-titulo/Poster.jsx
import React, { useEffect, useState } from "react";
import { buscarPosterPorTitulo } from "../../services/posterService";

function Poster({ titulo }) {
  const [poster, setPoster] = useState(null);

  useEffect(() => {
    if (!titulo) {
      setPoster(null);
      return;
    }

    async function load() {
      // busca o poster só com o nome — IMDB faz o resto
      const url = await buscarPosterPorTitulo(titulo.nome);
      setPoster(url);
    }

    load();
  }, [titulo]);

  return (
    <div
      style={{
        textAlign: "center",
        background: "#222",
        padding: "20px",
        borderRadius: "8px",
        minHeight: "400px",
        display: "flex",
        alignItems: "center",
        justifyContent: "center"
      }}
    >
      {poster ? (
        <img
          src={poster}
          alt={titulo.nome}
          style={{
            width: "100%",
            maxHeight: "500px",
            objectFit: "contain",
            borderRadius: "8px",
          }}
        />
      ) : (
        <p style={{ color: "#bbb" }}>Poster do Filme</p>
      )}
    </div>
  );
}

export default Poster;
