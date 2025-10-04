import React, { useState, useEffect } from "react";
import "../styles/modal.css";

function ClasseEditModal({ classe, onSave, onClose }) {
  const [nome, setNome] = useState("");
  const [valor, setValor] = useState("");
  const [dataDevolucao, setDataDevolucao] = useState("");

  useEffect(() => {
    if (classe) {
      setNome(classe.nome || "");
      setValor(
        classe.precoDiariaCentavos
          ? (classe.precoDiariaCentavos / 100).toFixed(2)
          : ""
      );
      setDataDevolucao(classe.dataDevolucao || "");
    }
  }, [classe]);

  if (!classe) return null;

  const handleSubmit = (e) => {
    e.preventDefault();

    const precoDiariaCentavos = Math.round(parseFloat(valor) * 100);

    if (!nome.trim() || isNaN(precoDiariaCentavos) || !dataDevolucao) {
      alert("Preencha todos os campos corretamente antes de salvar.");
      return;
    }

    const payload = {
      id: classe.id,
      nome: nome.trim(),
      precoDiariaCentavos,
      dataDevolucao,
      ativo: classe.ativo ?? true,
    };

    onSave(payload);
  };

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div className="modal-box" onClick={(e) => e.stopPropagation()}>
        <h3>Editar Classe</h3>
        <form onSubmit={handleSubmit} className="modal-form">
          <label>
            Nome:
            <input
              type="text"
              value={nome}
              onChange={(e) => setNome(e.target.value)}
            />
          </label>
          <label>
            Valor (R$):
            <input
              type="number"
              step="0.01"
              value={valor}
              onChange={(e) => setValor(e.target.value)}
            />
          </label>
          <label>
            Data de Devolução:
            <input
              type="date"
              value={dataDevolucao}
              onChange={(e) => setDataDevolucao(e.target.value)}
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

export default ClasseEditModal;
