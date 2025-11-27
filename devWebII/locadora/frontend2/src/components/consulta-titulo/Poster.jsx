// src/components/consulta-titulo/Poster.jsx
import React, { useEffect, useState } from "react";
import { buscarPoster } from "../../services/posterService";

function Poster({ titulo }) {
  const [poster, setPoster] = useState(null);

  useEffect(() => {
    if (!titulo) return;

    async function load() {
      const url = await buscarPoster(titulo.nome, titulo.ano);
      setPoster(url);
    }

    load();
  }, [titulo]);

  return (
    <div style={{ textAlign: "center", background: "#222", padding: "20px" }}>
      {poster ? (
        <img
          src={poster}
          alt={titulo.nome}
          style={{ width: "100%", borderRadius: "8px" }}
        />
      ) : (
        <p style={{ color: "#bbb" }}>Poster do Filme</p>
      )}
    </div>
  );
}

export default Poster;
