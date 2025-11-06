import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";
import SelectModal from "./ui/SelectModal";
import { getClientes } from "../services/clienteService";
import { getItens } from "../services/itemService";

function LocacaoForm({ onAdd }) {
  // Estados de seleção
  const [clienteSelecionado, setClienteSelecionado] = useState(null);
  const [itemSelecionado, setItemSelecionado] = useState(null);

  // Controle dos modais
  const [modalCliente, setModalCliente] = useState(false);
  const [modalItem, setModalItem] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!clienteSelecionado || !itemSelecionado) {
      alert("Selecione um cliente e um item para efetuar a locação.");
      return;
    }

    onAdd({
      clienteId: clienteSelecionado.id,
      itemId: itemSelecionado.id,
    });

    // limpa seleções
    setClienteSelecionado(null);
    setItemSelecionado(null);
  };

  return (
    <FormContainer title="Efetuar Nova Locação" onSubmit={handleSubmit}>
      {/* Selecionar Cliente */}
      <div className="input-field">
        <label>Cliente:</label>
        <input
          type="text"
          readOnly
          value={clienteSelecionado ? clienteSelecionado.nome : ""}
          placeholder="Nenhum cliente selecionado"
          onClick={() => setModalCliente(true)}
        />
        <button
          type="button"
          className="btn-select"
          onClick={() => setModalCliente(true)}
        >
          Selecionar
        </button>
      </div>

      {/* Selecionar Item */}
      <div className="input-field">
        <label>Item:</label>
        <input
          type="text"
          readOnly
          value={itemSelecionado ? itemSelecionado.numSerie : ""}
          placeholder="Nenhum item selecionado"
          onClick={() => setModalItem(true)}
        />
        <button
          type="button"
          className="btn-select"
          onClick={() => setModalItem(true)}
        >
          Selecionar
        </button>
      </div>

      <SubmitButton label="Registrar Locação" />

      {/* Modais de seleção retrô */}
      <SelectModal
        isOpen={modalCliente}
        title="Selecionar Cliente"
        fetchItems={getClientes}
        onSelect={(c) => setClienteSelecionado(c)}
        onClose={() => setModalCliente(false)}
      />

      <SelectModal
        isOpen={modalItem}
        title="Selecionar Item"
        fetchItems={getItens}
        onSelect={(i) => setItemSelecionado(i)}
        onClose={() => setModalItem(false)}
      />
    </FormContainer>
  );
}

export default LocacaoForm;
