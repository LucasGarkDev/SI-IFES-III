import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import { getItemFromId, getTitleItem } from "../js/utils.js";
import { update } from "../service/apiFunctions.js";
import Loading from "../components/subcomponents/Loading.jsx";
import SubMenu from "../components/SubMenu.jsx";

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
      const title =getTitleItem(formData)
      setLoading(true);
      setShowModal(false);

      window.addAlert(`✏️ Atualizando ${title}...`, "info");
      window.addAlert("📡 Enviando dados ao servidor...", "info");

      await update(moduleConfig.name, id, formData);

      window.addAlert(`✅ ${title} atualizado com sucesso!`, "success");
      console.log("[EditPage] Item atualizado com sucesso!");
    } catch (err) {
      window.addAlert(`❌ Falha ao atualizar! ${err}`, "danger");
      console.error("[EditPage] Erro ao salvar item:", err);
    } finally {
      await moduleConfig.syncData();
      window.addAlert("🏁 Processo finalizado", "success");
      setLoading(false);
    }
  };

   // Links do submenu
  const submenuLinks = [
    { path: `/${moduleConfig.name}`, label: "Listagem" },
    { path: `/${moduleConfig.name}/novo`, label: "Novo" },
    { path: `/${moduleConfig.name}/editar/${id}`, label: "Uau voce esta Editando! " },
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
