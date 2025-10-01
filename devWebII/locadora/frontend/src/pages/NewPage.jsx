import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import Form from "../components/Form.jsx"; // importando o componente dinâmico que criamos
import ConfirmModal from "../components/ConfirmModal.jsx";

const NewPage = ({ moduleConfig }) => {
	const [showModal, setShowModal] = useState(false);
	const [initialValues, setInitialValues] = useState({ nome: "" });

	const handleFormSubmit = (data) => {
		setShowModal(true);
	};

	return (
		<div>
			<h2>Inserir novos {moduleConfig.label}</h2>
			<Link
				to={`/${moduleConfig.name}/novo`}
				style={{ display: "inline-block", marginBottom: "20px" }}
			>
				+ Ver {moduleConfig.label}
			</Link>
			<Form
				btnTextContent="Inserir"
				fields={moduleConfig.newPageFields}
				onSubmit={handleFormSubmit}
				initialValues={initialValues}
			/>

			<ConfirmModal
        show={showModal}
        title="Confirmação"
        message="Deseja realmente Inserir?"
        onConfirm={() => {
          console.log("Item salvo!");
          setShowModal(false);
        }}
        onCancel={() => setShowModal(false)}
      />
		</div>
	);
};

export default NewPage;
