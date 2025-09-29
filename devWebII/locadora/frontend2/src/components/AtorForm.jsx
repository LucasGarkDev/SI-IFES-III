import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";

function AtorForm({ onAdd }) {
  const [nome, setNome] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    if (nome.trim()) {
      onAdd({ nome });
      setNome("");
    }
  };

  return (
    <FormContainer title="Cadastrar Ator" onSubmit={handleSubmit}>
      <InputField
        label="Nome do Ator"
        value={nome}
        onChange={(e) => setNome(e.target.value)}
      />
      <SubmitButton label="Adicionar" />
    </FormContainer>
  );
}

export default AtorForm;
