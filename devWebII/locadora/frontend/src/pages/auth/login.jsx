import React, { useState } from "react";
import { useParams, Link } from "react-router-dom";
import Form from "../../components/Form";
import { create } from "../../service/apiFunctions";

const AuthPage = ({ moduleConfig, userLoged, setUserLoged }) => {
	const [formData, setFormData] = useState(null);
  const exampleFields = { "usuario": "admin", "senha": "123456" };


  const handleFormSubmit = async (data) => {
    console.log("[NewPage] Dados do form:", data);
    setFormData(data); // salva os dados do form
		try {
			console.log("[NewPage] Criando item:", formData);
			// usa moduleConfig.name como endpoint
			await create(moduleConfig.name, formData);
			console.log("Login efetuado com sucesso!");
      setUserLoged(true);
		} catch (err) {
      setUserLoged(false);
			console.error("Erro ao fazer Login:", err);
		}
  };

  return (
    <div className="container flex">
      <h1>login</h1>
      <Form
        btnTextContent="Entrar"
        exampleObject={exampleFields}
        onSubmit={handleFormSubmit}
        initialValues={{}}
      />

      <Link to={`/home`}>Go to Home</Link>
    </div>
  );
};

export default AuthPage;
