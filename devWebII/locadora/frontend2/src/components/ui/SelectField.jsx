import React from "react";
import "../../styles/InputField.css"; // usa o mesmo estilo base

function SelectField({ label, value, onChange, options = [] }) {
  return (
    <div className="input-field">
      <label>{label}:</label>
      <select value={value} onChange={onChange}>
        <option value="">Selecione...</option>
        {options.map((opt) => (
          <option key={opt.value} value={opt.value}>
            {opt.label}
          </option>
        ))}
      </select>
    </div>
  );
}

export default SelectField;
