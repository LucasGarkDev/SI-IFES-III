import React, { useState, useEffect } from "react";
import FormButton from "./subcomponents/FormButton";
import FormField from "./subcomponents/FormField";
import { generateFormFields } from "../js/utils";

/**
 * @component Form
 * @description Form genérico dinâmico que renderiza campos a partir de um objeto de exemplo.
 * @param {string} btnTextContent - Texto do botão de envio.
 * @param {Object} exampleObject - Objeto exemplo com estrutura dos campos (ex: { nome: '', ativo: true, tipo: ['A', 'B', 'C'] }).
 * @param {Function} onSubmit - Função chamada ao enviar o formulário.
 * @param {Object} initialValues - Valores iniciais do formulário.
 * @return {JSX.Element}
 */
const Form = ({
  btnTextContent = "Salvar",
  exampleObject = {},
  onSubmit,
  initialValues = {},
}) => {
  const [values, setValues] = useState({});
  const [error, setError] = useState(null);

  // Gera campos dinamicamente
  const processedFields = generateFormFields(exampleObject)

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

  // 🔧 Corrige arrays de valor único antes do envio
  const fixedValues = Object.fromEntries(
    Object.entries(values).map(([key, value]) => {
      if (Array.isArray(value) && value.length === 1) return [key, value[0]];
      return [key, value];
    })
  );

  onSubmit(fixedValues);
};

  if (error) return <div className="alert alert-danger">{error}</div>;

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
