// src/wrappers/ModuleWrapper.jsx
import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { findModuleConfig } from "../js/utils";
import { syncData } from "../service/api";

const ModuleWrapper = ({ children }) => {
  const { moduleName, id } = useParams();
  const baseConfig = findModuleConfig(moduleName);
  const [data, setData] = useState(baseConfig?.data || []);

  const getRandomInt = (max) => Math.floor(Math.random() * max);

  const mensagensVazias = [
    "Ops! Parece que aqui não tem nada… nem poeira! 🧹",
    "Nada para mostrar… O fantasma dos dados levou tudo! 👻",
    "Tabela vazia! Hora de adicionar algum conteúdo, antes que ela fique triste 😢",
    "Hmm… nada aqui ainda. Talvez os dados estejam de férias 🌴",
    "Zero dados encontrados. Mas hey, pelo menos o café está garantido ☕",
    "Atenção! Este espaço está reservado para dados incríveis que ainda não chegaram 🚀",
  ];

  // Função local de sincronização para este módulo
  const syncDataLocal = async () => {
    try {
      await syncData(moduleName, setData);
    } catch (err) {
      console.error(`[ModuleWrapper] Erro ao sincronizar ${moduleName}:`, err);
    }
  };

  useEffect(() => {
    syncDataLocal();
    const interval = setInterval(syncDataLocal, 1000*35);
    return () => clearInterval(interval);
  }, [moduleName]);

  if (!baseConfig) {
    const msg = mensagensVazias[getRandomInt(mensagensVazias.length)];
    return <h2>{msg} — módulo "{moduleName}" não encontrado.</h2>;
  }

  if (!data || data.length === 0) {
    const msg = mensagensVazias[getRandomInt(mensagensVazias.length)];
    return <h2>{msg}</h2>;
  }

  console.log("🔁 ModuleWrapper sincronizado:", moduleName);

  return React.cloneElement(children, {
    moduleConfig: {
      ...baseConfig,
      data,
      syncData: syncDataLocal, // ✅ injetamos a função no config
    },
    setData, // opcional, se quiser manipular manualmente
    id,
  });
};

export default ModuleWrapper;