import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { findModuleConfig } from "../js/utils";
import { carregarBanco } from "../service/api";

const ModuleWrapper = ({ children }) => {
  const { moduleName, id } = useParams();
  const baseConfig = findModuleConfig(moduleName);
  const [data, setData] = useState(baseConfig?.data || []);

  // Atualiza automaticamente do backend
  useEffect(() => {
    const fetchData = async () => {
      const result = await carregarBanco(moduleName); // GET /api/{moduleName}
      setData(result);
    };

    fetchData();
    const interval = setInterval(fetchData, 15000); // sincronia automática
    return () => clearInterval(interval);
  }, [moduleName]);

  if (!baseConfig) return <h2>Módulo não encontrado: {moduleName}</h2>;

  console.log("ModuleWrapper recebeu novos dados:", baseConfig.data);

  console.log("ModuleWrapper: Renderizando módulo", moduleName, baseConfig);
  // Passa moduleConfig atualizado para a página
  return React.cloneElement(children, {
    moduleConfig: { ...baseConfig, data },
    id,
  });
};

export default ModuleWrapper;
