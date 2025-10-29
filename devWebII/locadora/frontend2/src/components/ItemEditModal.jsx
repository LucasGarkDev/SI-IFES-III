import React, { useState, useEffect } from "react";

function ItemEditModal({ item, onSave, onClose }) {
  const [numSerie, setNumSerie] = useState("");
  const [dtAquisicao, setDtAquisicao] = useState("");
  const [tipoItem, setTipoItem] = useState("");
  const [tituloId, setTituloId] = useState("");

  useEffect(() => {
    if (item) {
      setNumSerie(item.numSerie);
      setDtAquisicao(item.dtAquisicao);
      setTipoItem(item.tipoItem);
      setTituloId(item.tituloId);
    }
  }, [item]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = {
      ...item,
      numSerie,
      dtAquisicao,
      tipoItem,
      tituloId: parseInt(tituloId, 10),
    };
    onSave(payload);
  };

  if (!item) return null;

  return (
    <div className="modal">
      <div className="modal-content box">
        <h3>Editar Item</h3>
        <form onSubmit={handleSubmit}>
          <label>
            Nº de Série:
            <input type="text" value={numSerie} onChange={(e) => setNumSerie(e.target.value)} required />
          </label>
          <label>
            Data de Aquisição:
            <input type="date" value={dtAquisicao} onChange={(e) => setDtAquisicao(e.target.value)} required />
          </label>
          <label>
            Tipo do Item:
            <input type="text" value={tipoItem} onChange={(e) => setTipoItem(e.target.value)} required />
          </label>
          <label>
            ID do Título:
            <input type="number" value={tituloId} onChange={(e) => setTituloId(e.target.value)} required />
          </label>
          <button type="submit">Salvar</button>
          <button type="button" onClick={onClose}>Cancelar</button>
        </form>
      </div>
    </div>
  );
}

export default ItemEditModal;
