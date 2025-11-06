import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";
import SelectModal from "./ui/SelectModal";
import { getClientes } from "../services/clienteService";
import { getItens } from "../services/itemService";

function LocacaoForm({ onAdd }) {
  const [clienteSelecionado, setClienteSelecionado] = useState(null);
  const [itemSelecionado, setItemSelecionado] = useState(null);
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

    setClienteSelecionado(null);
    setItemSelecionado(null);
  };

  return (
    <FormContainer title="Efetuar Nova Locação" onSubmit={handleSubmit}>
      <div className="select-box">
        <label>Cliente:</label>
        <input
          type="text"
          readOnly
          value={clienteSelecionado ? clienteSelecionado.nome : ""}
          placeholder="Nenhum cliente selecionado"
        />
        <button type="button" onClick={() => setModalCliente(true)}>
          Selecionar
        </button>
      </div>

      <div className="select-box">
        <label>Item:</label>
        <input
          type="text"
          readOnly
          value={itemSelecionado ? itemSelecionado.numSerie : ""}
          placeholder="Nenhum item selecionado"
        />
        <button type="button" onClick={() => setModalItem(true)}>
          Selecionar
        </button>
      </div>

      <SubmitButton label="Registrar Locação" />

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
