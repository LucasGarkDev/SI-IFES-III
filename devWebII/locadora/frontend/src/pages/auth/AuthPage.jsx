// src/pages/auth/AuthPage.jsx
import React, { useState, useContext } from "react";
import { useNavigate } from "react-router-dom";
import Form from "../../components/Form";
import { create } from "../../service/apiFunctions";
import { AppContext } from "../../components/AppContext.jsx";

const AuthPage = ({ moduleConfig }) => {
  const { userLoged, setUserLoged, setUser } = useContext(AppContext);
  const [formData, setFormData] = useState({});
  const navigate = useNavigate();

  const exampleFields = { usuario: "admin", senha: "123456" };

  const handleFormSubmit = async (data) => {
    try {
      // Chama endpoint de login
      const response = await create("login", data); // ajusta para seu backend
      console.log("Login efetuado:", response);

      setUserLoged(true);
      setUser(response.user); // salva info do usuário
      navigate("/home"); // redireciona para home
    } catch (err) {
      setUserLoged(false);
      setUser(null);
      console.error("Erro ao fazer login:", err);
      alert("Usuário ou senha inválidos!");
    }
  };

  const handleFormSubmitDebug = async (data) => {
    if (!userLoged) {
      console.log(data)
      setUser(data)
      setUserLoged(true);
    } else {
      setUser(null)
      setUserLoged(false);
    }
  };

  if (userLoged) {
    return navigate("/home")
  }
  return (
    <div className="container flex">
      <h1>Login</h1>
      <Form
        btnTextContent="Entrar"
        exampleObject={exampleFields}
        onSubmit={handleFormSubmit}
        initialValues={{}}
      />

      <Form
        btnTextContent="[debug]Entrar"
        exampleObject={exampleFields}
        onSubmit={handleFormSubmitDebug}
        initialValues={{}}
      />
    </div>
  );
};

export default AuthPage;
