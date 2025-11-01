import React from "react";

/**
 * @component FormField
 * @description Campo de formulário dinâmico.
 * @param {Object} field - Dados do campo (name, label, type, options).
 * @param {any} value - Valor atual do campo.
 * @param {Function} onChange - Manipulador de mudança.
 * @return {JSX.Element}
 */
const FormField = ({ field, value, onChange }) => {
  const { name, label, type, options } = field;

  return (
    <div className="mb-3">
      <label htmlFor={name} className="form-label">
        {label}
      </label>

      {type === "select" ? (
        <select
          id={name}
          name={name}
          className="form-select"
          value={value || ""}
          onChange={onChange}
          required
        >
          <option value="">Selecione...</option>
          {options.map((opt, index) => (
            <option key={index} value={opt}>
              {opt}
            </option>
          ))}
        </select>
      ) : (
        <input
          id={name}
          name={name}
          type={type}
          className="form-control"
          value={type === "checkbox" ? undefined : value || ""}
          checked={type === "checkbox" ? value || false : undefined}
          onChange={onChange}
          required
        />
      )}
    </div>
  );
};

export default FormField;