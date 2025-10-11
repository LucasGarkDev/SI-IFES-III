import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import { getItemFromId, getTitleItem } from "../js/utils.js";
import Loading from "../components/Loading.jsx";
import { update } from "../service/apiFunctions.js";

const EditPage = ({ moduleConfig, id }) => {
  const atualItem = getItemFromId(id, moduleConfig.data);

  const [initialValues] = useState(atualItem || {});
  const [loading, setLoading] = useState(false);
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
      setLoading(true);
      setShowModal(false);

      window.addAlert(`✏️ Atualizando ${moduleConfig.name}...`, "info");
      window.addAlert("📡 Enviando dados ao servidor...", "info");

      await update(moduleConfig.name, id, formData);

      window.addAlert(`✅ ${moduleConfig.name} atualizado com sucesso!`, "success");
      console.log("[EditPage] Item atualizado com sucesso!");
    } catch (err) {
      window.addAlert("❌ Falha ao atualizar item!", "danger");
      console.error("[EditPage] Erro ao salvar item:", err);
    } finally {
      window.addAlert("🏁 Processo finalizado", "success");
      setLoading(false);
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
        message={`Deseja realmente editar ${getTitleItem(
          atualItem
        )} para ${getTitleItem(formData)}?`}
        onConfirm={handleConfirm}
        onCancel={() => setShowModal(false)}
      />

      {loading && <Loading message={`Editando ${moduleConfig.name}`} />}
    </div>
  );
};

export default EditPage;
