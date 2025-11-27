// src/components/consulta-titulo/SearchBar.jsx
import React, { useState } from "react";

function SearchBar({ onSearch }) {
  const [texto, setTexto] = useState("");

  function handleChange(e) {
    const value = e.target.value;
    setTexto(value);
    onSearch(value);
  }

  return (
    <div style={{ marginTop: "20px" }}>
      <input
        type="text"
        placeholder="Pesquisar título..."
        value={texto}
        onChange={handleChange}
        style={{
          width: "100%",
          padding: "12px",
          fontSize: "16px",
          borderRadius: "5px",
          border: "1px solid #ccc",
        }}
      />
    </div>
  );
}

export default SearchBar;
