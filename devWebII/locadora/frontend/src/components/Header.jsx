import React, { useContext } from "react";
import logo from "../assets/logo/video-locadora-retro-logo.png";
import { Link, useNavigate } from "react-router-dom";
import { AppContext } from "./AppContext.jsx";

const Header = () => {
  const { userLoged, setUserLoged, user } = useContext(AppContext); // pega do contexto
  const navigate = useNavigate();

  const handleAuthClick = () => {
    if (userLoged) {
      // Logout
      setUserLoged(false);
      navigate("/"); // volta pra login
    } else {
      // Login
      navigate("/"); // vai pra página de login
    }
  };

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

      <div className="d-flex align-items-center">
        {userLoged && user && (
          <span className="text fw-bold fst-italic fs-5 me-3">Bem-vindo, @{user}</span>
        )}
        <button className="btn btn-warning" onClick={handleAuthClick}>
          {userLoged ? "Sair" : "Entrar"}
        </button>
      </div>
    </header>
  );
};

export default Header;
