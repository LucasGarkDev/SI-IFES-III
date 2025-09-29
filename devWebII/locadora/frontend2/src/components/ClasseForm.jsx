import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";

function ClasseForm({ onAdd }) {
  const [nome, setNome] = useState("");
  const [valor, setValor] = useState("");
  const [dataDevolucao, setDataDevolucao] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    if (nome.trim() && valor && dataDevolucao) {
      onAdd({ nome, valor: parseFloat(valor), dataDevolucao });
      setNome("");
      setValor("");
      setDataDevolucao("");
    }
  };

  return (
    <FormContainer title="Cadastrar Classe" onSubmit={handleSubmit}>
      <InputField
        label="Nome da Classe"
        value={nome}
        onChange={(e) => setNome(e.target.value)}
      />
      <InputField
        label="Valor (R$)"
        type="number"
        value={valor}
        onChange={(e) => setValor(e.target.value)}
      />
      <InputField
        label="Data de Devolução"
        type="date"
        value={dataDevolucao}
        onChange={(e) => setDataDevolucao(e.target.value)}
      />
      <SubmitButton label="Adicionar" />
    </FormContainer>
  );
}

export default ClasseForm;
