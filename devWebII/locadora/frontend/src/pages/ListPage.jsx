import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import DynamicTable from "../components/DynamicTable";
import SubMenu from "../components/SubMenu.jsx";

/**
 * Página de listagem de módulos dinâmicos
 * @param {Object} moduleConfig - Configuração do módulo (label, name, data)
 * @return {JSX.Element}
 */
const ListPage = ({ moduleConfig }) => {
   //  moduleConfig e gerado pelo warper que retorna isso
  //   return React.cloneElement(children, {
  //     moduleConfig: {
  //       ...baseConfig,
  //       data,
  //       syncData: WARPSync, // ✅ injetamos a função no config
  //       errorMessages,
  //     },
  //     setData, // opcional, se quiser manipular manualmente
  //     id,
  //   });
  // };
  // moduleConfig.data e o que vem do banco
  const [tableData, setTableData] = useState([]);

  useEffect(() => {
    if (Array.isArray(moduleConfig.data)) {
      setTableData([...moduleConfig.data]);
    } else {
      setTableData([]);
    }
  }, [JSON.stringify(moduleConfig.data)]);

  // Links do submenu
  const submenuLinks = [
    { path: `/${moduleConfig.name}`, label: "Listagem" },
    { path: `/${moduleConfig.name}/novo`, label: "Novo" },
    // Você pode adicionar mais links específicos do módulo aqui
  ];

  return (
    <div>
      <h1>Lista de {moduleConfig.label}</h1>

      {/* Submenu horizontal */}
      <SubMenu links={submenuLinks} />

      <DynamicTable
        key={JSON.stringify(tableData)}
        data={tableData}
        moduleConfig={moduleConfig}
      />
    </div>
  );
};

export default ListPage;