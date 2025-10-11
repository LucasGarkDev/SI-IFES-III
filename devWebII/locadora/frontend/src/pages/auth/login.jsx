import React from "react";
import { useParams, Link } from "react-router-dom";
import Form from "../../components/Form";
import { create } from "../../service/apiFunctions";

const authPage = ({ moduleConfig }) => {
	const [formData, setFormData] = useState(null);
	console.log("Rendering authPage for module:", moduleConfig);
  const exampleFields = { usuario: "string", senha: "string" };


  const handleFormSubmit = async (data) => {
    console.log("[NewPage] Dados do form:", data);
    setFormData(data); // salva os dados do form
		try {
			console.log("[NewPage] Criando item:", formData);
			// usa moduleConfig.name como endpoint
			await create(moduleConfig.name, formData);
			console.log("Login efetuado com sucesso!");
		} catch (err) {
			console.error("Erro ao fazer Login:", err);
		}
  };

  return (
    <div>
      <h1>login</h1>
      <Form
        btnTextContent="Entrar"
        exampleObject={exampleFields}
        onSubmit={handleFormSubmit}
      />

      <Link to={`/`}>Go to Home</Link>
    </div>
  );
};

export default authPage;
