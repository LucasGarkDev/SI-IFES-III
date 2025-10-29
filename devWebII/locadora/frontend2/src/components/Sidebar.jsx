// Sidebar.jsx
import React from "react";
import "../styles/Sidebar.css";


function Sidebar({ onSelect }) {
  return (
    <aside className="sidebar">
      <nav>
        <ul>
          <li onClick={() => onSelect("atores")}>Atores</li>
          <li onClick={() => onSelect("diretores")}>Diretores</li>
          <li onClick={() => onSelect("classes")}>Classes</li>
          <li onClick={() => onSelect("itens")}>Itens</li>
          <li onClick={() => onSelect("titulos")}>Títulos</li>
          <li onClick={() => onSelect("clientes")}>Clientes</li>
        </ul>
      </nav>
    </aside>
  );
}

export default Sidebar;
