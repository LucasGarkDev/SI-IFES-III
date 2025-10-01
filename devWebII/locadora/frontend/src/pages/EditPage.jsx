import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";
import { extractKeys, getItemFromId } from "../js/utils.js";

const EditPage = ({ moduleConfig, id }) => {
  const [showModal, setShowModal] = useState(false);
  const atualItem = getItemFromId(id, moduleConfig.data); // Ajuste para acessar o item correto
  const [initialValues, setInitialValues] = useState({
    ...moduleConfig.data, // pega todos os campos
    nome: atualItem.name, // opcional, sobrescreve se quiser
  });
  console.log("atualItem:", atualItem);

  const handleSave = () => {
    // chama o modal antes de salvar
    setShowModal(true);
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
        fields={extractKeys(atualItem)}
        onSubmit={handleSave}
        initialValues={initialValues}
      />

      <ConfirmModal
        show={showModal}
        title="Confirmação"
        message="Deseja realmente salvar?"
        onConfirm={() => {
          console.log("Item salvo!");
          setShowModal(false);
        }}
        onCancel={() => setShowModal(false)}
      />
    </div>
  );
};

export default EditPage;
