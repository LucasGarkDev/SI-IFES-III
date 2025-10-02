import React, { useState, useEffect } from "react";

function ClasseEditModal({ classe, onSave, onClose }) {
  const [nome, setNome] = useState("");
  const [valor, setValor] = useState(""); // em reais (ex: 12.30)
  const [dataDevolucao, setDataDevolucao] = useState("");

  useEffect(() => {
    if (classe) {
      setNome(classe.nome);
      // converte do back (centavos) para reais com 2 casas
      setValor((classe.precoDiariaCentavos / 100).toFixed(2));
      setDataDevolucao(classe.dataDevolucao);
    }
  }, [classe]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = {
      ...classe,
      nome,
      // converte de reais para centavos (inteiro)
      precoDiariaCentavos: Math.round(parseFloat(valor) * 100),
      dataDevolucao,
    };
    onSave(payload);
  };

  if (!classe) return null;

  return (
    <div className="modal">
      <div className="modal-content box">
        <h3>Editar Classe</h3>
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
          <label>
            Valor (R$):
            <input
              type="number"
              step="0.01"
              value={valor}
              onChange={(e) => setValor(e.target.value)}
              required
            />
          </label>
          <label>
            Data de Devolução:
            <input
              type="date"
              value={dataDevolucao}
              onChange={(e) => setDataDevolucao(e.target.value)}
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

export default ClasseEditModal;
