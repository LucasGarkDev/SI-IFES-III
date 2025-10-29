import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";

function ItemForm({ onAdd }) {
  const [numSerie, setNumSerie] = useState("");
  const [dtAquisicao, setDtAquisicao] = useState("");
  const [tipoItem, setTipoItem] = useState("");
  const [tituloId, setTituloId] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    if (numSerie && dtAquisicao && tipoItem && tituloId) {
      onAdd({
        numSerie,
        dtAquisicao,
        tipoItem,
        tituloId: parseInt(tituloId, 10),
      });

      setNumSerie("");
      setDtAquisicao("");
      setTipoItem("");
      setTituloId("");
    }
  };

  return (
    <FormContainer title="Cadastrar Item" onSubmit={handleSubmit}>
      <InputField
        label="Nº de Série"
        value={numSerie}
        onChange={(e) => setNumSerie(e.target.value)}
      />
      <InputField
        label="Data de Aquisição"
        type="date"
        value={dtAquisicao}
        onChange={(e) => setDtAquisicao(e.target.value)}
      />
      <InputField
        label="Tipo do Item (FITA, DVD, BLURAY)"
        value={tipoItem}
        onChange={(e) => setTipoItem(e.target.value)}
      />
      <InputField
        label="ID do Título"
        type="number"
        value={tituloId}
        onChange={(e) => setTituloId(e.target.value)}
      />
      <SubmitButton label="Adicionar" />
    </FormContainer>
  );
}

export default ItemForm;
