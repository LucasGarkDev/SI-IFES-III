// src/components/Header.jsx
import React from "react";
import logo  from "../assets/logo/video-locadora-retro-logo.png";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <header className="navbar navbar-dark bg-dark px-3">
      <Link to="/" className="navbar-brand d-flex align-items-center">
        <img
          src={logo }
          alt="VideoLocadora"
          style={{ height: "40px", marginRight: "10px" }}
        />
        <span>VideoLocadora</span>
      </Link>
    </header>
  );
};

export default Header;
