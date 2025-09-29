import React, { useState, useEffect } from "react";

function AtorEditModal({ ator, onSave, onClose }) {
  const [nome, setNome] = useState("");

  useEffect(() => {
    if (ator) setNome(ator.nome);
  }, [ator]);

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave({ ...ator, nome });
  };

  if (!ator) return null;

  return (
    <div className="modal">
      <div className="modal-content box">
        <h3>Editar Ator</h3>
        <form onSubmit={handleSubmit}>
          <label>
            Nome:
            <input
              type="text"
              value={nome}
              onChange={(e) => setNome(e.target.value)}
            />
          </label>
          <button type="submit">Salvar</button>
          <button type="button" onClick={onClose}>
            Cancelar
          </button>
        </form>
      </div>
    </div>
  );
}

export default AtorEditModal;
