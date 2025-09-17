import React from "react";
import { Link } from "react-router-dom";

const ActorList = () => {
	return (
		<div>
			<h1>Lista de Atores</h1>
			<Link to="/atores/novo">+ Novo Ator</Link>
			{/* Aqui viria a tabela/lista de atores */}
		</div>
	);
};

export default ActorList;
