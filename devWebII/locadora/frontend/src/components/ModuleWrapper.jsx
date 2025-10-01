// src/js/ModuleWrapper.jsx
import React from "react";
import { useParams } from "react-router-dom";
import { findModuleConfig } from "../js/utils";

/*
	ModuleWrapper é um "envoltório" para páginas dinâmicas de módulos.
	Ele:
		1. Pega o nome do módulo da URL via useParams()
		2. Busca a configuração do módulo (dados, label, etc.) usando findModuleConfig()
		3. Se não encontrar, retorna um JSX de fallback
		4. Se encontrar, injeta a moduleConfig como prop no componente filho automaticamente
			usando React.cloneElement

	Isso permite que você não precise repetir if(!moduleConfig) e useParams() em todas as páginas
*/
const ModuleWrapper = ({ children }) => {
  const { moduleName,id } = useParams(); // Pega o parâmetro da URL
  const moduleConfig = findModuleConfig(moduleName); // Busca configuração do módulo

  if (!moduleConfig) {
    // Caso módulo não exista, mostra mensagem de erro
    return (
      <div className="p-3">
        <h2 className="text-danger">Módulo não encontrado: {moduleName}</h2>
      </div>
    );
  }

  /*
		React.cloneElement pega o componente filho passado (children) e adiciona props nele.
		No caso, estamos passando moduleConfig como prop.
		Assim, dentro do ListPage, NewPage ou EditPage você já recebe:
			props.moduleConfig
		sem precisar buscar novamente.
	*/
	console.log("ModuleWrapper: Renderizando módulo", moduleName, moduleConfig);
  return React.cloneElement(children, { moduleConfig,id });
};

export default ModuleWrapper;
