import React from "react";
import "../../styles/modal.css"; // reutiliza o estilo do modal já existente

function ConfirmModal({ isOpen, onConfirm, onCancel, itemName }) {
  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={onCancel}>
      <div className="modal-box" onClick={(e) => e.stopPropagation()}>
        <h3>Confirmar Exclusão</h3>
        <p>
          Tem certeza que deseja excluir{" "}
          <strong>{itemName ? `"${itemName}"` : "este item"}</strong>?
          <br />
          Esta ação não poderá ser desfeita.
        </p>

        <div className="modal-actions">
          <button onClick={onConfirm} className="btn-delete">
            Excluir
          </button>
          <button onClick={onCancel} className="btn-cancel">
            Cancelar
          </button>
        </div>
      </div>
    </div>
  );
}

export default ConfirmModal;
