import React, { useState } from "react";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { create } from "../service/api.js";
import { getTitleItem } from "../js/utils.js";
import Loading from "../components/Loading.jsx"; // Importar o overlay

const NewPage = ({ moduleConfig }) => {
  const firstItem = moduleConfig.data?.[0] || {};
  const [initialValues] = useState(firstItem);
  const [formData, setFormData] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [loading, setLoading] = useState(false); // Estado para controlar o overlay

  const handleFormSubmit = (data) => {
    console.log("[NewPage] Dados do form:", data);
    setFormData(data);
    setShowModal(true);
  };

  const handleConfirm = async () => {
    try {
      setLoading(true); // Ativa o overlay
      setShowModal(false);

      console.log("[NewPage] Criando item:", formData);
      await create(moduleConfig.name, formData);

      console.log("[NewPage] Item salvo com sucesso!");
    } catch (err) {
      console.error("[NewPage] Erro ao salvar item:", err);
    } finally {
      setLoading(false); // Desativa o overlay mesmo se der erro
    }
  };

  return (
    <div>
      <h2>Inserir novos {moduleConfig.label}</h2>

      <Link
        to={`/${moduleConfig.name}`}
        style={{ display: "inline-block", marginBottom: "20px" }}
      >
        + Ver {moduleConfig.label}
      </Link>

      <Form
        btnTextContent={`Inserir ${moduleConfig.label}`}
        exampleObject={firstItem}
        onSubmit={handleFormSubmit}
        initialValues={initialValues}
      />

      <ConfirmModal
        show={showModal}
        title="Confirmação"
        message={`Deseja realmente inserir ${getTitleItem(formData)}?`}
        onConfirm={handleConfirm}
        onCancel={() => setShowModal(false)}
      />

      {/* Overlay de Loading */}
      {loading && <Loading message={`Criando ${moduleConfig.name}`} />}
    </div>
  );
};

export default NewPage;
