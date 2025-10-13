import React from "react";
import { useParams, Link } from "react-router-dom";
import DynamicTable from "../components/DynamicTable";

const ListPage = ({ moduleConfig }) => {
  console.log("Rendering ListPage for module:", moduleConfig);

  return (
    <div>
      <h1>Lista de {moduleConfig.label}</h1>
      <Link
        to={`/${moduleConfig.name}/novo`}
        style={{ display: "inline-block", marginBottom: "20px" }}
      >
        + Inserir novos {moduleConfig.label}
      </Link>

      <DynamicTable data={moduleConfig.data} />
    </div>
  );
};

export default ListPage;
