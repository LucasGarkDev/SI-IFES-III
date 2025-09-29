import React, { useState, useEffect } from "react";

function DiretorEditModal({ diretor, onSave, onClose }) {
  const [nome, setNome] = useState("");

  useEffect(() => {
    if (diretor) setNome(diretor.nome);
  }, [diretor]);

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave({ ...diretor, nome });
  };

  if (!diretor) return null;

  return (
    <div className="modal">
      <div className="modal-content box">
        <h3>Editar Diretor</h3>
        <form onSubmit={handleSubmit}>
          <label>
            Nome:
            <input
              type="text"
              value={nome}
              onChange={(e) => setNome(e.target.value)}
              required
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

export default DiretorEditModal;
