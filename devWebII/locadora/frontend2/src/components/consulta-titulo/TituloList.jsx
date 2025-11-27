// src/components/consulta-titulo/TituloList.jsx
import React from "react";

function TituloList({ resultados, onSelect }) {
  return (
    <div
      style={{
        background: "#1a1a1a",
        padding: "15px",
        borderRadius: "8px",
        minHeight: "400px",
      }}
    >
      <h3>Resultados da pesquisa</h3>

      {resultados.length === 0 && <p>Nenhum título encontrado.</p>}

      <ul style={{ listStyle: "none", padding: 0 }}>
        {resultados.map((t) => (
          <li
            key={t.id}
            onClick={() => onSelect(t.id)}
            style={{
              padding: "10px",
              borderBottom: "1px solid #333",
              cursor: "pointer",
            }}
          >
            {t.nome}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default TituloList;
