// src/components/Loading.jsx
import React from "react";
import PropTypes from "prop-types"; // opcional, mas bom pra validar props

const Loading = ({ message = "Carregando" }) => {
  return (
    <div className="loading-overlay">
      <div
        className="spinner-border text-light"
        role="status"
        style={{ width: "4rem", height: "4rem" }}
      >
        <span className="visually-hidden">Carregando...</span>
      </div>
      <p className="mt-3 text-white">{message}...</p>
    </div>
  );
};

Loading.propTypes = {
  message: PropTypes.string,
};

export default Loading;
