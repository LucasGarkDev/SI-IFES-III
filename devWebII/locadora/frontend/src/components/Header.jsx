import React from "react";
import logoSpotify from "../assets/logo/spotify-logo.png";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <header>
      <Link to="/">
        <img src={logoSpotify} alt="VideoLocadora" />
      </Link>

      <Link className="header__link" href="/">
        <h1>VideoLocadora</h1>
      </Link>
    </header>
  );
};

export default Header;
