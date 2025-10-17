import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import DynamicTable from "../components/DynamicTable";

const ListPage = ({ moduleConfig }) => {
  const [tableData, setTableData] = useState(moduleConfig.data);

  // Supondo que você tem alguma função que atualiza moduleConfig.data (ex: após sync)
  // você pode usar um efeito para atualizar o estado local:
  useEffect(() => {
    setTableData(moduleConfig.data);
  }, [moduleConfig.data]);

  console.log("Rendering ListPage with data:", tableData);

  return (
    <div>
      <h1>Lista de {moduleConfig.label}</h1>
      <Link
        to={`/${moduleConfig.name}/novo`}
        style={{ display: "inline-block", marginBottom: "20px" }}
      >
        + Inserir novos {moduleConfig.label}
      </Link>

      <DynamicTable data={tableData} />
    </div>
  );
};

export default ListPage;
