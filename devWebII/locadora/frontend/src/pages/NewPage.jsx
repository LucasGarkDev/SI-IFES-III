import React, { useState } from "react";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { create } from "../service/apiFunctions.js";
import Loading from "../components/subcomponents/Loading.jsx";
import SubMenu from "../components/SubMenu.jsx";
import { getNomeItem } from "../js/modulesDataUtils.js";

const NewPage = ({ moduleConfig }) => {
  const descricao = moduleConfig.description || "Nenhuma descrição fornecida.";
  const firstItem = moduleConfig.data?.[0] || moduleConfig.databaseSchema;
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

      console.log("[NewPage] Criando item:", formData);
      await create(moduleConfig.name, formData);
      console.log("[NewPage] Item salvo com sucesso!");
    } finally {
      await moduleConfig.syncData();
      setLoading(false);
    }
  };

  // Links do submenu
  const submenuLinks = [
    { path: `/${moduleConfig.name}`, label: "Listagem" },
    { path: `/${moduleConfig.name}/novo`, label: "Novo" },
    // Você pode adicionar mais links específicos do módulo aqui
  ];

  return (
    <div>
      <h2>Inserir novos {moduleConfig.label}</h2>

      {/* Submenu horizontal */}
      <SubMenu links={submenuLinks} />

      <p>{descricao}</p>

      <Form
        btnTextContent={`Inserir ${moduleConfig.label}`}
        exampleObject={firstItem}
        onSubmit={handleFormSubmit}
        initialValues={initialValues}
      />

      <ConfirmModal
        show={showModal}
        title="Confirmação"
        message={`Deseja realmente inserir ${getNomeItem(formData)}?`}
        onConfirm={handleConfirm}
        onCancel={() => setShowModal(false)}
      />

      {/* Overlay de Loading */}
      {loading && <Loading message={`Criando ${moduleConfig.name}`} />}
    </div>
  );
};

export default NewPage;
