/**
 * Utils para pegar valores de campos de itens de módulos
 */

/* === Campos gerais === */

/**
 * Retorna o ID do item (procura por 'id' ou '_id').
 * @param {Object} item
 * @returns {number|string|null}
 */
export const getIDItem = (item) => item?.id ?? item?._id ?? null;

/**
 * Retorna o nome
 * @param {Object} item
 * @returns {string|null}
 */
export const getNomeItem = (item) => item?.nome ?? null;

/**
 * Retorna o ano
 * @param {Object} item
 * @returns {number|null}
 */
export const getAnoItem = (item) => item?.ano ?? null;

/**
 * Retorna a sinopse
 * @param {Object} item
 * @returns {string|null}
 */
export const getSinopseItem = (item) => item?.sinopse ?? null;

/**
 * Retorna a categoria
 * @param {Object} item
 * @returns {string|null}
 */
export const getCategoriaItem = (item) => item?.categoria ?? null;

/**
 * Retorna o ID da classe
 * @param {Object} item
 * @returns {number|null}
 */
export const getClasseIdItem = (item) => item?.classeId ?? null;

/**
 * Retorna o ID do diretor
 * @param {Object} item
 * @returns {number|null}
 */
export const getDiretorIdItem = (item) => item?.diretorId ?? null;

/**
 * Retorna os IDs de atores
 * @param {Object} item
 * @returns {Array<number>}
 */
export const getAtoresIdsItem = (item) => item?.atoresIds ?? [];

/**
 * Retorna a data de nascimento
 * @param {Object} item
 * @returns {string|null}
 */
export const getDtNascimentoItem = (item) => item?.dtNascimento ?? null;

/**
 * Retorna o sexo
 * @param {Object} item
 * @returns {string|null}
 */
export const getSexoItem = (item) => item?.sexo ?? null;

/**
 * Retorna o CPF
 * @param {Object} item
 * @returns {string|null}
 */
export const getCpfItem = (item) => item?.cpf ?? null;

/**
 * Retorna o endereço
 * @param {Object} item
 * @returns {string|null}
 */
export const getEnderecoItem = (item) => item?.endereco ?? null;

/**
 * Retorna o telefone
 * @param {Object} item
 * @returns {string|null}
 */
export const getTelefoneItem = (item) => item?.telefone ?? null;

/**
 * Retorna os dependentes (array de objetos)
 * @param {Object} item
 * @returns {Array<Object>}
 */
export const getDependentesItem = (item) => item?.dependentes ?? [];

/**
 * Retorna um dependente específico pelo índice
 * @param {Object} item
 * @param {number} index
 * @returns {Object|null}
 */
export const getDependenteItem = (item, index) => item?.dependentes?.[index] ?? null;

/**
 * Retorna um campo específico de um dependente
 * @param {Object} dependente
 * @param {string} field
 * @returns {*}
 */
export const getDependenteField = (dependente, field) => dependente?.[field] ?? null;
