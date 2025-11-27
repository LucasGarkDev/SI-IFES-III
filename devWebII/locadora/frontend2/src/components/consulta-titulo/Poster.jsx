// src/components/consulta-titulo/Poster.jsx
import React from "react";

function Poster({ titulo }) {
  return (
    <div
      style={{
        background: "#222",
        height: "280px",
        borderRadius: "8px",
        marginBottom: "15px",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        color: "#999",
      }}
    >
      {titulo ? "Poster do Filme" : "Nenhum título selecionado"}
    </div>
  );
}

export default Poster;
