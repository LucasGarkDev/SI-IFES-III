import React, { useState } from "react";
import Header from "./components/Header";
import Sidebar from "./components/Sidebar";
import MainContent from "./components/MainContent";
import "./styles/global.css";

function App() {
  // Estado que guarda qual opção do menu foi selecionada
  const [selected, setSelected] = useState(null);

  return (
    <div className="app-container">
      {/* Cabeçalho */}
      <Header />

      <div className="content-wrapper">
        {/* Barra lateral */}
        <Sidebar onSelect={setSelected} />

        {/* Conteúdo principal */}
        <MainContent selected={selected} />
      </div>
    </div>
  );
}

export default App;

