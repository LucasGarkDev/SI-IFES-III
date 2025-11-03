import React from "react";
import { Link } from "react-router-dom";
import "../css/NotFound.css"; // (opcional se quiser estilizar separado)

const NotFound = () => {
  return (
    <main className="main not-found">
      <h1>404 - Página Não Encontrada</h1>
      <p>A página que você tentou acessar não existe ou foi removida.</p>
      <Link to="/home" className="back-home">← Voltar para a página inicial</Link>
    </main>
  );
};

export default NotFound;
