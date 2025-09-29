import React from "react";
import "../../styles/buttons.css";

function SubmitButton({ label }) {
  return (
    <button type="submit" className="action-btn add">
      {label}
    </button>
  );
}

export default SubmitButton;
