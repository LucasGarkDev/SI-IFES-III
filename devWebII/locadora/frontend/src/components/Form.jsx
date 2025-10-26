import React, { useState, useEffect } from "react";
import FormButton from "./subcomponents/FormButton";
import FormField from "./subcomponents/FormField";

const Form = ({
  btnTextContent = "Salvar",
  exampleObject = {},
  onSubmit,
  initialValues = {},
}) => {
  const [values, setValues] = useState({});
  const [error, setError] = useState(null);

  // Processa os campos dinamicamente
  const processedFields = Object.entries(exampleObject)
    .filter(([key]) => key !== "id" && key !== "_id")
    .map(([key, value]) => {
      let type = "text";
      if (key.toLowerCase().includes("senha")) type = "password";
      else if (typeof value === "number") type = "number";
      else if (typeof value === "boolean") type = "checkbox";
      else if (typeof value === "string" && /^\d{2}\/\d{2}\/\d{4}$/.test(value))
        type = "date";

      return {
        name: key,
        label: key.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase()),
        type,
      };
    });

  useEffect(() => {
    if (!exampleObject || typeof exampleObject !== "object" || Array.isArray(exampleObject)) {
      setError("Erro: formato inválido de campos. Ex: { nome: 'abc', valor: 5 }.");
    } else setError(null);
  }, [exampleObject]);

  useEffect(() => {
    setValues(initialValues);
  }, [initialValues]);

  const handleChange = (e) => {
    const { name, type, value, checked } = e.target;
    setValues({ ...values, [name]: type === "checkbox" ? checked : value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(values);
  };

  if (error) {
    return <div className="alert alert-danger">{error}</div>;
  }

  return (
    <form onSubmit={handleSubmit} className="p-3 border rounded bg-light">
      {processedFields.map((field) => (
        <FormField
          key={field.name}
          field={field}
          value={values[field.name]}
          onChange={handleChange}
        />
      ))}
      <FormButton text={btnTextContent} />
    </form>
  );
};

export default Form;