import React from "react";
import "../styles/MainContent.css";
import AtoresPage from "../pages/AtoresPage";
import ClassesPage from "../pages/ClassesPage";
import DiretoresPage from "../pages/DiretoresPage";

function MainContent({ selected }) {
  return (
    <main className="main-content">
      {selected === "atores" && <AtoresPage />}
      {selected === "diretores" && <DiretoresPage />}
      {selected === "classes" && <ClassesPage />}
      {!selected && <h2>Bem-vindo! Selecione uma opção no menu.</h2>}
    </main>
  );
}

export default MainContent;
