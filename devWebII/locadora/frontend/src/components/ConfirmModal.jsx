import React from "react";

const ConfirmModal = ({ show, title, message, onConfirm, onCancel }) => {
  if (!show) return null;

  const handleConfirm = () => {
    onConfirm && onConfirm();
  };

  const handleCancel = () => {
    onCancel && onCancel();
  };

  return (
    <>
      {/* Fundo esmaecido */}
      <div className="modal-backdrop-fade"></div>

      {/* Modal */}
      <div className="modal fade show d-block" tabIndex="-1" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h5 className="modal-title">{title}</h5>
              <button type="button" className="btn-close" onClick={handleCancel}></button>
            </div>
            <div className="modal-body">
              <p>{message}</p>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={handleCancel}>
                Cancelar
              </button>
              <button className="btn btn-primary" onClick={handleConfirm}>
                Ok
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

// example usage:
// <ConfirmModal
//         show={showModal}
//         title="Confirmação"
//         message="Deseja realmente salvar?"
//         onConfirm={() => {
//           console.log("Item salvo!");
//           setShowModal(false);
//         }}
//         onCancel={() => setShowModal(false)}
//       />

export default ConfirmModal;