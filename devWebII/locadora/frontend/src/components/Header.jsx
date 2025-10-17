import React, { useState, useEffect, useRef } from "react";
import logo from "../assets/logo/video-locadora-retro-logo.png";
import { Link } from "react-router-dom";
import { syncData } from "../service/api";

const Header = () => {
  const [autoSync, setAutoSync] = useState(false);
  const seconds = 25;
  const intervalId = useRef(null);

  const toggleAutoSync = () => {
    setAutoSync(prev => !prev);
  };

  useEffect(() => {
    if (autoSync) {
      // Ativa o intervalo e salva o ID
      intervalId.current = setInterval(() => {
        syncData();
        console.log("Sincronizando automaticamente...");
      }, 1000 * seconds);

      window.addAlert("Auto Sync está ativado!", "info");
    } else {
      // Desativa o intervalo, se existir
      if (intervalId.current) {
        clearInterval(intervalId.current);
        intervalId.current = null;
      }
      window.addAlert("Auto Sync está desativado!", "warning");
    }

    // Limpeza ao desmontar o componente
    return () => {
      if (intervalId.current) {
        clearInterval(intervalId.current);
      }
    };
  }, [autoSync]);

  return (
    <header className="navbar navbar-dark bg-dark px-3 justify-content-between">
      <Link to="/" className="navbar-brand d-flex align-items-center">
        <img
          src={logo}
          alt="VideoLocadora"
          style={{ height: "40px", marginRight: "10px" }}
        />
        <span>VideoLocadora</span>
      </Link>

      <button
        className={`btn ${autoSync ? "btn-success" : "btn-outline-light"}`}
        onClick={toggleAutoSync}
      >
        {autoSync ? `Auto Sync Ativado (${seconds}s)` : "Auto Sync Desativado"}
      </button>
    </header>
  );
};

export default Header;
