import React from "react";
import "../styles/Header.css";

function Header() {
  return (
    <header className="header">
      <div className="header-content">
        {/* <img
          src="../assets/vite.svg"
          alt="Logo Vite"
          className="header-logo"
        /> */}
        <h1 className="header-title">Locadora Passatempo</h1>
      </div>
    </header>
  );
}

export default Header;
