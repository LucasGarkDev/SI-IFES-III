import React, { useState } from "react";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { getTitleItem } from "../js/utils.js";
import Loading from "../components/Loading.jsx"; // Importar o overlay
import { create } from "../service/apiFunctions.js";
import { carregarBanco } from "../service/api.js";

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
      setLoading(true);
      setShowModal(false);

      window.addAlert(`🔄 Criando ${getTitleItem(formData)}...`, "info");

      console.log("[NewPage] Criando item:", formData);
      window.addAlert("📤 Enviando dados ao servidor...", "info");
      await create(moduleConfig.name, formData);

      window.addAlert(`✅ ${getTitleItem(formData)} criado com sucesso!`, "success");
      console.log("[NewPage] Item salvo com sucesso!");
    } catch (err) {
      window.addAlert(`❌ Falha ao criar! ${err}`, "danger");
      console.error("[NewPage] Erro ao salvar item:", err);
    } finally {
      carregarBanco(moduleConfig.name);
      window.addAlert("✅ Processo finalizado", "success");
      setLoading(false);
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
