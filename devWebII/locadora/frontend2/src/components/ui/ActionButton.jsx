import React from "react";
import "../../styles/buttons.css";

function ActionButton({ label, onClick, type = "button", variant = "default" }) {
  return (
    <button
      className={`action-btn ${variant}`}
      onClick={onClick}
      type={type}
    >
      {label}
    </button>
  );
}

export default ActionButton;
