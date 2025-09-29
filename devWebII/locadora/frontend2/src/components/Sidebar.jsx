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
        </ul>
      </nav>
    </aside>
  );
}

export default Sidebar;
