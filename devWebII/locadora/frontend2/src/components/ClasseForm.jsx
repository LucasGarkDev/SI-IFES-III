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

    if (!nome.trim() || !valor || !dataDevolucao) {
      alert("Preencha todos os campos antes de cadastrar.");
      return;
    }

    const precoDiariaCentavos = Math.round(parseFloat(valor) * 100);

    if (isNaN(precoDiariaCentavos) || precoDiariaCentavos <= 0) {
      alert("O valor deve ser um número maior que zero.");
      return;
    }

    const novaClasse = {
      nome: nome.trim(),
      precoDiariaCentavos,
      dataDevolucao,
      ativo: true,
    };

    console.log("📤 Enviando para criação:", novaClasse);
    onAdd(novaClasse);

    setNome("");
    setValor("");
    setDataDevolucao("");
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
        step="0.01"
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
