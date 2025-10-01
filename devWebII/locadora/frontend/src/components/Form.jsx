// src/components/Form.jsx
import React, { useState, useEffect } from "react";

const Form = ({ btnTextContent = "Salvar",fields = [], onSubmit, initialValues = {} }) => {
  const [values, setValues] = useState({});
  console.log("[FORM] Rendering Form with fields:", fields);
  console.log("[FORM] Initial values:", initialValues);

  // Processa fields, ignora "id"
  const processedFields = fields
    .filter((field) => field !== "id") // ❌ ignora "id"
    .map((field) => {
      if (typeof field === "string") {
        return {
          name: field,
          label: field
            .replace(/_/g, " ")
            .replace(/\b\w/g, (l) => l.toUpperCase()),
          type: "text",
        };
      }
      return field; // já é objeto
    });

  useEffect(() => {
    setValues(initialValues);
  }, [initialValues]);

  const handleChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(values);
  };

  return (
    <form onSubmit={handleSubmit} className="p-3 border rounded bg-light">
      {processedFields.map((field) => (
        <div className="mb-3" key={field.name}>
          <label htmlFor={field.name} className="form-label">
            {field.label}
          </label>
          <input
            id={field.name}
            name={field.name}
            type={field.type || "text"}
            className="form-control"
            value={values[field.name] || ""}
            onChange={handleChange}
            placeholder={field.placeholder || ""}
            required={field.required || false}
          />
        </div>
      ))}
      <button type="submit" className="btn btn-primary">
        {btnTextContent}
      </button>
    </form>
  );
};

export default Form;
