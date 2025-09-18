import React, { useState, useEffect } from "react";

const Form = ({ fields, onSubmit, initialValues = {} }) => {
  const [values, setValues] = useState({});

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
    <form onSubmit={handleSubmit}>
      {fields.map((field) => (
        <div key={field.name} style={{ marginBottom: "10px" }}>
          <label htmlFor={field.name}>{field.label}</label>
          <input
            id={field.name}
            name={field.name}
            type={field.type || "text"}
            value={values[field.name] || ""}
            onChange={handleChange}
            placeholder={field.placeholder}
            required={field.required}
          />
        </div>
      ))}
      <button type="submit">Salvar</button>
    </form>
  );
};

export default Form;
