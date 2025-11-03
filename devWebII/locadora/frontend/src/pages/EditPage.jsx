import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import Loading from "../components/subcomponents/Loading.jsx";
import SubMenu from "../components/SubMenu.jsx";
import { getItemById } from "../js/modulesItensFilterUtils.js";
import { getNomeItem } from "../js/modulesDataUtils.js";
import { update } from "../service/apiFunctions.js";

const EditPage = ({ moduleConfig, id }) => {
  //  moduleConfig e gerado pelo warper que retorna isso
  //   return React.cloneElement(children, {
  //     moduleConfig: {
  //       ...baseConfig,
  //       data,
  //       syncData: WARPSync, // ✅ injetamos a função no config
  //       errorMessages,
  //     },
  //     setData, // opcional, se quiser manipular manualmente
  //     id,
  //   });
  // };
  // moduleConfig.data e o que vem do banco
  // Retorna um item de um array pelo ID.
  const atualItem = getItemById(moduleConfig.data, id);

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

      await update(moduleConfig.name, id, formData);
      console.log("[EditPage] Item atualizado com sucesso!");
    }finally {
      await moduleConfig.syncData();
        setLoading(false);
    }
  };

  // Links do submenu
  const submenuLinks = [
    { path: `/${moduleConfig.name}`, label: "Listagem" },
    { path: `/${moduleConfig.name}/novo`, label: "Novo" },
    {
      path: `/${moduleConfig.name}/editar/${id}`,
      label: `Uau! Editando ${getNomeItem(atualItem)}! `,
    },
    // Você pode adicionar mais links específicos do módulo aqui
  ];
  return (
    <div className="container flex flex-column align-items-center">
      <h2>Editar {moduleConfig.label}</h2>
      {/* Submenu horizontal */}
      <SubMenu links={submenuLinks} />

      <Form
        btnTextContent="Editar"
        exampleObject={atualItem}
        onSubmit={handleFormSubmit}
        initialValues={initialValues}
      />

      <ConfirmModal
        show={showModal}
        title="Confirmação"
        message={`Deseja realmente editar ${getNomeItem(
          atualItem
        )} para ${getNomeItem(formData)}?`}
        onConfirm={handleConfirm}
        onCancel={() => setShowModal(false)}
      />

      {loading && <Loading message={`Editando ${moduleConfig.name}`} />}
    </div>
  );
};

export default EditPage;
