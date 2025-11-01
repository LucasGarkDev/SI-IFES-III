// utils/modulesUtils.js

import modules from "../config/modules";

/**
 * @description Retorna todos os módulos.
 * @return {Array<Object>}
 */
export const getAllModules = () => modules;

/**
 * @description Retorna um módulo pelo nome.
 * @param {string} moduleName
 * @return {Object | undefined}
 */
export const getModuleByName = (moduleName) =>
	modules.find((mod) => mod.name === moduleName);

/**
 * @description Retorna o label de um módulo pelo nome.
 * @param {string} moduleName
 * @return {string | undefined}
 */
export const getModuleLabel = (moduleName) =>
	getModuleByName(moduleName)?.label;

/**
 * @description Retorna a descrição de um módulo pelo nome.
 * @param {string} moduleName
 * @return {string | undefined}
 */
export const getModuleDescription = (moduleName) =>
	getModuleByName(moduleName)?.description;

/**
 * @description Retorna o schema de banco (databaseSchema) de um módulo.
 * @param {string} moduleName
 * @return {Object | undefined}
 */
export const getModuleSchema = (moduleName) =>
	getModuleByName(moduleName)?.databaseSchema;

/**
 * @description Retorna os dados filtrados de um módulo.
 * @param {string} moduleName
 * @return {Array<Object> | undefined}
 */
export const getModuleData = (moduleName) =>
	getModuleByName(moduleName)?.data;

/**
 * @description Retorna o payload mínimo esperado pelo backend.
 * @param {string} moduleName
 * @return {Object | undefined}
 */
export const getModuleBackendPayload = (moduleName) =>
	getModuleByName(moduleName)?.backendPayloadMinimalRequired;

/**
 * @description Retorna o nome de um item pelo id (assume que o módulo tem campo 'id' e 'nome').
 * @param {string} moduleName
 * @param {number} id
 * @return {string | undefined}
 */
export const getItemNameById = (moduleName, id) => {
	const data = getModuleData(moduleName);
	return data?.find((item) => item.id === id)?.nome;
};

/**
 * @description Retorna um item completo pelo id.
 * @param {string} moduleName
 * @param {number} id
 * @return {Object | undefined}
 */
export const getItemById = (moduleName, id) => {
	const data = getModuleData(moduleName);
	return data?.find((item) => item.id === id);
};

/**
 * @description Retorna o primeiro item de um módulo.
 * @param {string} moduleName
 * @return {Object | undefined}
 */
export const getFirstItem = (moduleName) => getModuleData(moduleName)?.[0];

/**
 * @description Retorna todos os nomes de um módulo (array de strings).
 * @param {string} moduleName
 * @return {Array<string> | undefined}
 */
export const getAllItemNames = (moduleName) =>
	getModuleData(moduleName)?.map((item) => item.nome);

/**
 * @description Retorna todos os IDs de um módulo (array de números).
 * @param {string} moduleName
 * @return {Array<number> | undefined}
 */
export const getAllItemIds = (moduleName) =>
	getModuleData(moduleName)?.map((item) => item.id);

/**
 * @description Retorna os campos do schema de um módulo.
 * @param {string} moduleName
 * @return {Array<string> | undefined}
 */
export const getSchemaFields = (moduleName) =>
	Object.keys(getModuleSchema(moduleName) || {});

/**
 * @description Retorna true se o módulo existe.
 * @param {string} moduleName
 * @return {boolean}
 */
export const moduleExists = (moduleName) =>
	!!getModuleByName(moduleName);
