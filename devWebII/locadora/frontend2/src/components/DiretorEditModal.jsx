import React, { useState, useEffect } from "react";
import "../styles/modal.css";

function DiretorEditModal({ diretor, onSave, onClose }) {
  const [nome, setNome] = useState("");

  useEffect(() => {
    if (diretor) setNome(diretor.nome || "");
  }, [diretor]);

  if (!diretor) return null;

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!nome.trim()) {
      alert("O nome do diretor é obrigatório.");
      return;
    }

    const payload = {
      id: diretor.id,
      nome: nome.trim(),
      ativo: diretor.ativo ?? true,
    };

    onSave(payload);
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box" onClick={(e) => e.stopPropagation()}>
        <h3>Editar Diretor</h3>
        <form onSubmit={handleSubmit} className="modal-form">
          <label>
            Nome do Diretor:
            <input
              type="text"
              value={nome}
              onChange={(e) => setNome(e.target.value)}
            />
          </label>

          <div className="modal-actions">
            <button type="submit" className="btn-save">
              Salvar
            </button>
            <button type="button" onClick={onClose} className="btn-cancel">
              Cancelar
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default DiretorEditModal;
