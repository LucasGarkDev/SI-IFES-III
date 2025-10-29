import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";

function TituloForm({ onAdd }) {
  const [nome, setNome] = useState("");
  const [ano, setAno] = useState("");
  const [sinopse, setSinopse] = useState("");
  const [categoria, setCategoria] = useState("");
  const [classeId, setClasseId] = useState("");
  const [diretorId, setDiretorId] = useState("");
  const [atoresIds, setAtoresIds] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    if (nome && ano && categoria && classeId && diretorId && atoresIds) {
      const ids = atoresIds.split(",").map((id) => parseInt(id.trim(), 10));
      onAdd({
        nome,
        ano: parseInt(ano, 10),
        sinopse,
        categoria,
        classeId: parseInt(classeId, 10),
        diretorId: parseInt(diretorId, 10),
        atoresIds: ids,
      });
      setNome("");
      setAno("");
      setSinopse("");
      setCategoria("");
      setClasseId("");
      setDiretorId("");
      setAtoresIds("");
    }
  };

  return (
    <FormContainer title="Cadastrar Título" onSubmit={handleSubmit}>
      <InputField label="Nome" value={nome} onChange={(e) => setNome(e.target.value)} />
      <InputField label="Ano" type="number" value={ano} onChange={(e) => setAno(e.target.value)} />
      <InputField label="Categoria" value={categoria} onChange={(e) => setCategoria(e.target.value)} />
      <InputField label="Sinopse" value={sinopse} onChange={(e) => setSinopse(e.target.value)} />
      <InputField label="ID da Classe" type="number" value={classeId} onChange={(e) => setClasseId(e.target.value)} />
      <InputField label="ID do Diretor" type="number" value={diretorId} onChange={(e) => setDiretorId(e.target.value)} />
      <InputField
        label="IDs dos Atores (separados por vírgula)"
        value={atoresIds}
        onChange={(e) => setAtoresIds(e.target.value)}
      />
      <SubmitButton label="Adicionar" />
    </FormContainer>
  );
}

export default TituloForm;
