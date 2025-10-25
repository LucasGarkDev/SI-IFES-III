import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import DynamicTable from "../components/DynamicTable";

/**
 * Página de listagem de módulos dinâmicos
 * @param {Object} moduleConfig - Configuração do módulo (label, name, data)
 * @return {JSX.Element}
 */
const ListPage = ({ moduleConfig }) => {
<<<<<<< HEAD
  const [tableData, setTableData] = useState([]);

  useEffect(() => {
    // Garante nova referência e dispara re-render
    if (Array.isArray(moduleConfig.data)) {
      setTableData([...moduleConfig.data]);
    } else {
      setTableData([]);
    }
  }, [JSON.stringify(moduleConfig.data)]); // Detecta mudanças profundas
=======
  const [tableData, setTableData] = useState(moduleConfig.data);

  // Supondo que você tem alguma função que atualiza moduleConfig.data (ex: após sync)
  // você pode usar um efeito para atualizar o estado local:
  useEffect(() => {
    setTableData(moduleConfig.data);
  }, [moduleConfig.data]);
>>>>>>> 7bfbf535e7d95b9f97bb8e223d3354bdbe9ece3f

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

<<<<<<< HEAD
      {/* Força re-render quando tableData muda */}
      <DynamicTable key={JSON.stringify(tableData)} data={tableData} />
=======
      <DynamicTable data={tableData} />
>>>>>>> 7bfbf535e7d95b9f97bb8e223d3354bdbe9ece3f
    </div>
  );
};

export default ListPage;
