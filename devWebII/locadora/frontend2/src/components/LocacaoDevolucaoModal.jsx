import React, { useState, useEffect } from "react";
import "../styles/InputField.css";
import ActionButton from "./ui/ActionButton"; // ✅ importa o componente

function LocacaoDevolucaoModal({ isOpen, locacao, onConfirm, onClose }) {
  const [dataHoje, setDataHoje] = useState("");
  const [diasAtraso, setDiasAtraso] = useState(0);
  const [multa, setMulta] = useState(0);

  useEffect(() => {
    if (locacao && isOpen) {
      const hoje = new Date();
      setDataHoje(hoje.toISOString().slice(0, 10));

      const prevista = new Date(locacao.dataPrevistaDevolucao);
      const diffDias = Math.floor((hoje - prevista) / (1000 * 60 * 60 * 24));
      const atraso = diffDias > 0 ? diffDias : 0;
      setDiasAtraso(atraso);

      if (atraso > 0) {
        const valorBase = (locacao.valorCentavos || 0) / 100;
        const valorMulta = (valorBase * 0.1 * atraso).toFixed(2);
        setMulta(parseFloat(valorMulta));
      } else {
        setMulta(0);
      }
    }
  }, [locacao, isOpen]);

  if (!isOpen || !locacao) return null;

  const handleConfirmar = () => {
    onConfirm({
      ...locacao,
      dataEfetivaDevolucao: dataHoje,
      multa: parseFloat(multa),
    });
  };

  return (
    <div className="modal-overlay">
      <div className="modal-box">
        <h3>Confirmar Devolução</h3>
        <p>
          Item:{" "}
          <strong>
            {locacao.item?.numSerie || locacao.itemId}{" "}
            ({locacao.item?.tipoItem})
          </strong>
        </p>
        <p>
          Cliente: <strong>{locacao.cliente?.nome || locacao.clienteId}</strong>
        </p>

        <hr style={{ margin: "10px 0" }} />

        <p>
          Data prevista:{" "}
          <strong>{locacao.dataPrevistaDevolucao || "—"}</strong>
        </p>
        <p>
          Data de hoje: <strong>{dataHoje}</strong>
        </p>

        {diasAtraso > 0 ? (
          <>
            <p style={{ color: "red" }}>
              ⚠ O item está com <strong>{diasAtraso}</strong> dia(s) de atraso.
            </p>

            <div className="input-field">
              <label>Definir multa (R$):</label>
              <input
                type="number"
                step="0.01"
                min="0"
                value={multa}
                onChange={(e) => setMulta(e.target.value)}
                style={{ width: "100px" }}
              />
            </div>
          </>
        ) : (
          <p style={{ color: "green" }}>✅ Nenhum atraso detectado.</p>
        )}

        {/* ✅ Substituído por ActionButton */}
        <div style={{ textAlign: "right", marginTop: "16px" }}>
          <ActionButton
            label="Cancelar"
            variant="delete"
            onClick={onClose}
          />
          <ActionButton
            label="Confirmar"
            variant="edit"
            onClick={handleConfirmar}
            style={{ marginLeft: "8px" }}
          />
        </div>
      </div>
    </div>
  );
}

export default LocacaoDevolucaoModal;
