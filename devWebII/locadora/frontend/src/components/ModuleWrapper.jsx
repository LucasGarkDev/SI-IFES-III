import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { findModuleConfig } from "../js/utils";
import { carregarBanco } from "../service/api";

const ModuleWrapper = ({ children }) => {
  const { moduleName, id } = useParams();
  const baseConfig = findModuleConfig(moduleName);
  const [data, setData] = useState(baseConfig?.data || []);

  // Função para gerar número aleatório
  const getRandomInt = (max) => Math.floor(Math.random() * max);

  // Mensagens engraçadas
  const mensagensVazias = [
    "Ops! Parece que aqui não tem nada… nem poeira!",
    "Nada para mostrar… O fantasma dos dados levou tudo! 👻",
    "Tabela vazia! Hora de adicionar algum conteúdo, antes que ela fique triste 😢",
    "Hmm… nada aqui ainda. Talvez os dados estejam de férias 🌴",
    "Zero dados encontrados. Mas hey, pelo menos o café está garantido ☕",
    "Atenção! Este espaço está reservado para dados incríveis que ainda não chegaram 🚀",
  ];

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

  // Caso o módulo não exista
  if (!baseConfig) {
    const mensagemAleatoria = mensagensVazias[getRandomInt(mensagensVazias.length)];
    return <h2>{mensagemAleatoria} — módulo "{moduleName}" não encontrado.</h2>;
  }

  // Caso o módulo exista mas não tenha dados
  if (data.length === 0) {
    const mensagemAleatoria = mensagensVazias[getRandomInt(mensagensVazias.length)];
    return <h2>{mensagemAleatoria}</h2>;
  }

  console.log("ModuleWrapper recebeu novos dados:", baseConfig.data);
  console.log("ModuleWrapper: Renderizando módulo", moduleName, baseConfig);

  // Passa moduleConfig atualizado para a página
  return React.cloneElement(children, {
    moduleConfig: { ...baseConfig, data },
    id,
  });
};

export default ModuleWrapper;