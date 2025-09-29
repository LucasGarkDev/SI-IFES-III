import React from "react";
import "../../styles/forms.css";

function InputField({ label, type = "text", value, onChange, required = true }) {
  return (
    <div className="input-field">
      <label>
        {label}:
        <input
          type={type}
          value={value}
          onChange={onChange}
          required={required}
        />
      </label>
    </div>
  );
}

export default InputField;
