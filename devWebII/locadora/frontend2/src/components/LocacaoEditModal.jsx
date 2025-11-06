import React, { useState, useEffect } from "react";
import "../styles/modal.css";

function LocacaoEditModal({ locacao, onSave, onClose }) {
  const [valorCentavos, setValorCentavos] = useState("");
  const [dataPrevistaDevolucao, setDataPrevistaDevolucao] = useState("");
  const [paga, setPaga] = useState(false);

  useEffect(() => {
    if (locacao) {
      setValorCentavos(locacao.valorCentavos || "");
      setDataPrevistaDevolucao(locacao.dataPrevistaDevolucao || "");
      setPaga(locacao.paga || false);
    }
  }, [locacao]);

  if (!locacao) return null;

  const handleSubmit = (e) => {
    e.preventDefault();
    onSave({
      id: locacao.id,
      valorCentavos: parseInt(valorCentavos, 10),
      dataPrevistaDevolucao,
      paga,
    });
  };

  return (
    <div className="modal-overlay">
      <div className="modal-box">
        <h3>Editar Locação</h3>
        <form onSubmit={handleSubmit}>
          <label>Valor (centavos):</label>
          <input
            type="number"
            value={valorCentavos}
            onChange={(e) => setValorCentavos(e.target.value)}
            required
          />

          <label>Data prevista de devolução:</label>
          <input
            type="date"
            value={dataPrevistaDevolucao}
            onChange={(e) => setDataPrevistaDevolucao(e.target.value)}
            required
          />

          <label>
            <input
              type="checkbox"
              checked={paga}
              onChange={(e) => setPaga(e.target.checked)}
            />
            Pago
          </label>

          <div className="modal-actions">
            <button type="submit" className="btn-green">
              Salvar
            </button>
            <button
              type="button"
              className="btn-cancel"
              onClick={onClose}
            >
              Fechar
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default LocacaoEditModal;
