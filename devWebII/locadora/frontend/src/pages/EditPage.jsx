import React, { useState } from "react";
import ConfirmModal from "../components/ConfirmModal.jsx";
import { Link } from "react-router-dom";
import Form from "../components/Form.jsx";

const EditPage = ({ moduleConfig, id }) => {
  const [showModal, setShowModal] = useState(false);
  const [initialValues, setInitialValues] = useState({
  ...moduleConfig.data[0],        // pega todos os campos
  nome: moduleConfig.data[0].name // opcional, sobrescreve se quiser
});
  alert("ID do item a ser editado: " + id);

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
        fields={moduleConfig.fields}
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
