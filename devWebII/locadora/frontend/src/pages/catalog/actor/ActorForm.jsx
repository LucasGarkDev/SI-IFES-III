import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import Form from "../../../components/Form.jsx"; // importando o componente dinâmico que criamos

const ActorForm = () => {
  const { id } = useParams();
  const isEditing = Boolean(id);

  const [initialValues, setInitialValues] = useState({ nome: "" });

  useEffect(() => {
    if (isEditing) {
      // Aqui você buscaria os dados do ator pelo ID
      // Exemplo simulado:
      const ator = { nome: "Leonardo DiCaprio" };
      setInitialValues(ator);
    }
  }, [id, isEditing]);

  const handleFormSubmit = (data) => {
    if (isEditing) {
      console.log("Atualizando ator:", data);
      // Chamada API para atualizar ator
    } else {
      console.log("Cadastrando novo ator:", data);
      // Chamada API para criar ator
    }
  };

  // Configuração de campos do formulário
  const fields = [
    {
      name: "nome",
      label: "Nome do Ator",
      type: "text",
      placeholder: "Nome do ator",
      required: true,
    },
  ];

  return (
    <div>
      <h2>{isEditing ? "Editar Ator" : "Cadastrar Novo Ator"}</h2>
      <Form
        fields={fields}
        onSubmit={handleFormSubmit}
        initialValues={initialValues}
      />
    </div>
  );
};

export default ActorForm;
