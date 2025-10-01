import React, { useState, useEffect } from "react";

const Form = ({
  btnTextContent = "Salvar",
  fields = [],
  onSubmit,
  initialValues = {},
}) => {
  const [values, setValues] = useState({});
  const [error, setError] = useState(null);
  console.log("[FORM] Rendering Form with fields:", fields);
  console.log("[FORM] Initial values:", initialValues);


  // ⚠️ Verifica se é um array de strings
  const isValidArrayOfStrings =
    Array.isArray(fields) && fields.every((f) => typeof f === "string");

  useEffect(() => {
    if (!isValidArrayOfStrings) {
      console.error(
        "[FORM] Erro: 'fields' deve ser um array de strings, como ['id', 'descricao']."
      );
      setError(
        "Erro: formato inválido de campos. Esperado um array de strings como ['id', 'descricao']."
      );
    } else {
      setError(null);
    }
  }, [fields]);

  // Se for inválido, processedFields será vazio
const processedFields = isValidArrayOfStrings
  ? fields
      .filter((field) => field !== "id" && field !== "_id") // Ignora 'id' e '_id'
      .map((field) => ({
        name: field,
        label: field
          .replace(/_/g, " ")
          .replace(/\b\w/g, (l) => l.toUpperCase()),
        type: "text",
      }))
  : [];

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
            value={values[field.name] || ""}
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