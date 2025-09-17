import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

const ActorForm = () => {
	const { id } = useParams();
	const isEditing = Boolean(id);

	const [nome, setNome] = useState("");

	useEffect(() => {
		if (isEditing) {
			// Carrega dados do ator com ID
			// setNome(ator.nome)
		}
	}, [id]);

	const handleSubmit = (e) => {
		e.preventDefault();
		if (isEditing) {
			// Atualiza ator
		} else {
			// Cadastra novo ator
		}
	};

	return (
		<form onSubmit={handleSubmit}>
			<h2>{isEditing ? "Editar Ator" : "Cadastrar Novo Ator"}</h2>
			<input
				type="text"
				value={nome}
				onChange={(e) => setNome(e.target.value)}
				placeholder="Nome do ator"
				required
			/>
			<button type="submit">Salvar</button>
		</form>
	);
};

export default ActorForm;
