// src/components/Form.jsx
import React, { useState, useEffect } from "react";

const Form = ({
  btnTextContent = "Salvar",
  exampleObject = {}, // agora espera um objeto com valores de exemplo
  onSubmit,
  initialValues = {},
}) => {
  const [values, setValues] = useState({});
  const [error, setError] = useState(null);

  console.log("[FORM] Rendering Form with exampleObject (objeto de exemplo):", exampleObject);
  console.log("[FORM] Initial values:", initialValues);

  // Gera automaticamente os campos com base no objeto "fields"
  const processedFields = Object.entries(exampleObject)
    .filter(([key]) => key !== "id" && key !== "_id") // ignora id
    .map(([key, value]) => {
      let type = "text";

      if (typeof value === "number") {
        type = "number";
      } else if (typeof value === "boolean") {
        type = "checkbox";
      } else if (
        typeof value === "string" &&
        /^\d{2}\/\d{2}\/\d{4}$/.test(value)
      ) {
        // formato dd/mm/yyyy
        type = "date";
      }

      return {
        name: key,
        label: key
          .replace(/_/g, " ")
          .replace(/\b\w/g, (l) => l.toUpperCase()),
        type,
      };
    });

  useEffect(() => {
    if (!exampleObject || typeof exampleObject !== "object" || Array.isArray(exampleObject)) {
      console.error(
        "[FORM] Erro: 'exampleObject' deve ser um objeto exemplo, ex: { nome: 'abc', valor: 5 }"
      );
      setError(
        "Erro: formato inválido de campos. Esperado um objeto exemplo, como { nome: 'abc', valor: 5 }."
      );
    } else {
      setError(null);
    }
  }, [exampleObject]);

  useEffect(() => {
    setValues(initialValues);
  }, [initialValues]);

  const handleChange = (e) => {
    const { name, type, value, checked } = e.target;
    setValues({
      ...values,
      [name]: type === "checkbox" ? checked : value,
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(values);
  };

  if (error) {
    return (
      <div className="alert alert-danger" role="alert">
        {error}
      </div>
    );
  }

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
            type={field.type}
            className="form-control"
            value={
              field.type === "checkbox"
                ? undefined
                : values[field.name] || exampleObject[field.name] || ""
            }
            checked={field.type === "checkbox" ? values[field.name] || false : undefined}
            onChange={handleChange}
            required
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