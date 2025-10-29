// MainContext.jsx
import React from "react";
import "../styles/MainContent.css";
import AtoresPage from "../pages/AtoresPage";
import ClassesPage from "../pages/ClassesPage";
import DiretoresPage from "../pages/DiretoresPage";

// ✅ Adicione estas linhas abaixo
import ItensPage from "../pages/ItensPage";
import TitulosPage from "../pages/TitulosPage";
import ClientesPage from "../pages/ClientesPage";

function MainContent({ selected }) {
  return (
    <main className="main-content">
      {selected === "atores" && <AtoresPage />}
      {selected === "diretores" && <DiretoresPage />}
      {selected === "classes" && <ClassesPage />}
      {selected === "itens" && <ItensPage />}
      {selected === "titulos" && <TitulosPage />}
      {selected === "clientes" && <ClientesPage />}
      {!selected && <h2>Bem-vindo! Selecione uma opção no menu.</h2>}
    </main>
  );
}

export default MainContent;
