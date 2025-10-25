import React, { useState, useEffect, useRef } from "react";
import logo from "../assets/logo/video-locadora-retro-logo.png";
import { Link } from "react-router-dom";
import { syncData } from "../service/api";

const Header = () => {
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
    </header>
  );
};

export default Header;
