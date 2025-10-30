import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";
import SelectModal from "./ui/SelectModal"; // seletor retrô
import { getTitulos } from "../services/tituloService"; // busca títulos

function ItemForm({ onAdd }) {
  const [numSerie, setNumSerie] = useState("");
  const [dtAquisicao, setDtAquisicao] = useState("");
  const [tipoItem, setTipoItem] = useState("");
  const [tituloSelecionado, setTituloSelecionado] = useState(null); // objeto título
  const [modalAberto, setModalAberto] = useState(false); // controla popup

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!numSerie || !dtAquisicao || !tipoItem || !tituloSelecionado) {
      alert("Preencha todos os campos e selecione um título!");
      return;
    }

    onAdd({
      numSerie,
      dtAquisicao,
      tipoItem,
      tituloId: tituloSelecionado.id,
    });

    // limpa os campos
    setNumSerie("");
    setDtAquisicao("");
    setTipoItem("");
    setTituloSelecionado(null);
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

      {/* Campo de título com seletor retrô */}
      <div className="input-field">
        <label>Título:</label>
        <input
          type="text"
          readOnly
          value={tituloSelecionado ? tituloSelecionado.nome : ""}
          placeholder="Nenhum título selecionado"
          onClick={() => setModalAberto(true)}
        />
        <button
          type="button"
          className="btn-select"
          onClick={() => setModalAberto(true)}
        >
          Selecionar
        </button>
      </div>

      <SubmitButton label="Adicionar" />

      {/* Popup para seleção de título */}
      <SelectModal
        isOpen={modalAberto}
        title="Selecionar Título"
        fetchItems={getTitulos}
        onSelect={(titulo) => setTituloSelecionado(titulo)}
        onClose={() => setModalAberto(false)}
      />
    </FormContainer>
  );
}

export default ItemForm;
