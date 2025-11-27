// Arquivo: locadora/frontend2/src/pages/AdminLayout.jsx
import React, { useState } from "react";
import Header from "../components/Header";
import Sidebar from "../components/Sidebar";
import MainContent from "../components/MainContent";
import "../styles/global.css";

function AdminLayout() {
  // Mantemos o estado de seleção do menu exatamente como no App.jsx antigo
  const [selected, setSelected] = useState(null);

  return (
    <div className="app-container">
      {/* Cabeçalho do layout administrativo */}
      <Header />

      <div className="content-wrapper">
        {/* Barra lateral com as opções de navegação */}
        <Sidebar onSelect={setSelected} />

        {/* Conteúdo principal baseado na opção escolhida */}
        <MainContent selected={selected} />
      </div>
    </div>
  );
}

export default AdminLayout;
