// src/components/consulta-titulo/TituloDetalhes.jsx
import React from "react";

function TituloDetalhes({ titulo }) {
  if (!titulo)
    return <p style={{ color: "#ccc" }}>Selecione um título para ver detalhes.</p>;

  return (
    <div
      style={{
        background: "#1a1a1a",
        padding: "15px",
        borderRadius: "8px",
        color: "white",
      }}
    >
      <h2>{titulo.nome}</h2>

      <p><strong>Ano:</strong> {titulo.ano}</p>
      <p><strong>Categoria:</strong> {titulo.categoria}</p>
      <p><strong>Diretor:</strong> {titulo.diretorNome}</p>

      <p><strong>Atores:</strong></p>
      <ul>
        {titulo.atores.map((a, i) => (
          <li key={i}>{a}</li>
        ))}
      </ul>

      <p><strong>Classe:</strong> {titulo.classeNome}</p>
      <p><strong>Valor da Locação:</strong> R$ {(titulo.valorLocacao / 100).toFixed(2)}</p>
      <p><strong>Quantidade de Fitas Disponíveis:</strong> {titulo.quantidadeDisponivel}</p>

      <p><strong>Sinopse:</strong> {titulo.sinopse}</p>
    </div>
  );
}

export default TituloDetalhes;
