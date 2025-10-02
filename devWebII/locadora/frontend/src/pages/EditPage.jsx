import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import { extractKeys, getItemFromId, getTitleItem } from "../js/utils.js";
import { update } from "../service/api.js";

const EditPage = ({ moduleConfig, id }) => {
  const atualItem = getItemFromId(id, moduleConfig.data);

  // Faz checagem de segurança
  const [initialValues, setInitialValues] = useState(atualItem || {});

  const [formData, setFormData] = useState(null);
  const [showModal, setShowModal] = useState(false);

  if (!atualItem) {
    return <div>Item com ID {id} não encontrado.</div>;
  }

  const handleFormSubmit = (data) => {
    console.log("[EditPage] Dados do form:", data);
    setFormData(data);
    setShowModal(true);
  };

  const handleConfirm = async () => {
    try {
      setShowModal(false);
      console.log("[HANDLE_CONFIRM] Atualizando item:", formData);
      await update(moduleConfig.name, id, formData);
      console.log("[HANDLE_CONFIRM] Item salvo com sucesso!");
    } catch (err) {
      console.error("[HANDLE_CONFIRM] Erro ao salvar item:", err);
      setShowModal(false);
    }
  };

  return (
    <div className="container flex flex-column align-items-center">
      <h2>Editar {moduleConfig.label}</h2>
      <Link
        to={`/${moduleConfig.name}/novo`}
        style={{ display: "inline-block", marginBottom: "20px" }}
      >
        + Inserir novos {moduleConfig.label}
      </Link>

      <Form
        btnTextContent="Editar"
        exampleObject={atualItem}
        onSubmit={handleFormSubmit}
        initialValues={initialValues}
      />

      <ConfirmModal
        show={showModal}
        title="Confirmação"
        message={`Deseja realmente editar ${getTitleItem(atualItem)} para ${getTitleItem(formData)}?`}
        onConfirm={handleConfirm}
        onCancel={() => setShowModal(false)}
      />
    </div>
  );
};

export default EditPage;