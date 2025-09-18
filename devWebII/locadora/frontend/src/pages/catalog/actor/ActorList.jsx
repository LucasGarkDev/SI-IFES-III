import React from "react";
import { Link } from "react-router-dom";
import { atoresArray } from "../../../assets/database/atores.js"; // Importando o array de atores
import DynamicTable from "../../../components/DynamicTable.jsx"; // Importando nossa tabela dinâmica

const ActorList = () => {
  return (
    <div>
      <h1>Lista de Atores</h1>
      <Link
        to="/atores/novo"
        style={{ display: "inline-block", marginBottom: "20px" }}
      >
        + Novo Ator
      </Link>

      {/* Tabela dinâmica */}
      <DynamicTable data={atoresArray} />
    </div>
  );
};

export default ActorList;
