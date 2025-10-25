// src/components/Header.jsx
import React from "react";
import logo from "../assets/logo/video-locadora-retro-logo.png";
import { Link, useNavigate } from "react-router-dom";

const Header = ({ userLoged, setUserLoged }) => {
  const navigate = useNavigate();

  const handleAuthClick = () => {
    if (userLoged) {
      // Logout
      setUserLoged(false);
      navigate("/"); // volta pra login
    } else {
      // Login
      navigate("/login");
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

      <button
        className="btn btn-warning"
        onClick={handleAuthClick}
      >
        {userLoged ? "Sair" : "Entrar"}
      </button>
    </header>
  );
};

export default Header;
