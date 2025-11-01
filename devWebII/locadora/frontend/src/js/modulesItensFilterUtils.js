/**
 * Utils para itens filtrados nos arrays de cada módulo
 */

/* === Campos simples === */

// src/js/modulesDataFilterUtils.js
/**
 * Retorna o item de um array pelo ID.
 * @param {Array<Object>} array - Array de objetos.
 * @param {number|string} id - ID a ser buscado.
 * @returns {Object|undefined} Item encontrado.
 */
/**
 * Busca um item em um array pelo ID, com log para depuração.
 * @param {Array<Object>} array - Array de objetos
 * @param {number|string} id - ID a ser buscado
 * @returns {Object|undefined} Item encontrado
 */
export const getItemById = (array, id) => {
  const numericId = Number(id);
  const found = array.find((item) => item.id === numericId);

  if (!found) {
    console.warn(`Item com ID ${id} não encontrado.`);
  } else {
    console.log("Item encontrado:", found);
  }

  return found;
};


/**
 * Filtra itens pelo nome (case insensitive).
 * @param {Array<Object>} array
 * @param {string} nome
 * @returns {Array<Object>}
 */
export const getByNome = (array, nome) =>
  array.filter((item) => item.nome?.toLowerCase() === nome.toLowerCase());

/**
 * Filtra itens pelo ano.
 * @param {Array<Object>} array
 * @param {number} ano
 * @returns {Array<Object>}
 */
export const getByAno = (array, ano) => array.filter((item) => item.ano === ano);

/**
 * Filtra itens pela sinopse (case insensitive, busca parcial).
 * @param {Array<Object>} array
 * @param {string} sinopse
 * @returns {Array<Object>}
 */
export const getBySinopse = (array, sinopse) =>
  array.filter((item) => item.sinopse?.toLowerCase().includes(sinopse.toLowerCase()));

/**
 * Filtra itens pela categoria (case insensitive).
 * @param {Array<Object>} array
 * @param {string} categoria
 * @returns {Array<Object>}
 */
export const getByCategoria = (array, categoria) =>
  array.filter((item) => item.categoria?.toLowerCase() === categoria.toLowerCase());

/**
 * Filtra itens pela data de devolução.
 * @param {Array<Object>} array
 * @param {string} data
 * @returns {Array<Object>}
 */
export const getByDataDevolucao = (array, data) =>
  array.filter((item) => item.dataDevolucao === data);

/**
 * Filtra itens pelo preço em centavos.
 * @param {Array<Object>} array
 * @param {number} preco
 * @returns {Array<Object>}
 */
export const getByPrecoDiariaCentavos = (array, preco) =>
  array.filter((item) => item.precoDiariaCentavos === preco);

/**
 * Filtra itens pelo número de série (case insensitive).
 * @param {Array<Object>} array
 * @param {string} numSerie
 * @returns {Array<Object>}
 */
export const getByNumSerie = (array, numSerie) =>
  array.filter((item) => item.numSerie?.toLowerCase() === numSerie.toLowerCase());

/**
 * Filtra itens pelo tipo de item (case insensitive).
 * @param {Array<Object>} array
 * @param {string} tipo
 * @returns {Array<Object>}
 */
export const getByTipoItem = (array, tipo) =>
  array.filter((item) => item.tipoItem?.toLowerCase() === tipo.toLowerCase());

/**
 * Filtra itens pelo ID do título.
 * @param {Array<Object>} array
 * @param {number} id
 * @returns {Array<Object>}
 */
export const getByTituloId = (array, id) => array.filter((item) => item.tituloId === id);

/**
 * Filtra itens pelo nome do título (case insensitive).
 * @param {Array<Object>} array
 * @param {string} nome
 * @returns {Array<Object>}
 */
export const getByTituloNome = (array, nome) =>
  array.filter((item) => item.tituloNome?.toLowerCase() === nome.toLowerCase());

/**
 * Filtra itens pelo ID da classe.
 * @param {Array<Object>} array
 * @param {number} id
 * @returns {Array<Object>}
 */
export const getByClasseId = (array, id) => array.filter((item) => item.classeId === id);

/**
 * Filtra itens pelo nome da classe (case insensitive).
 * @param {Array<Object>} array
 * @param {string} nome
 * @returns {Array<Object>}
 */
export const getByClasseNome = (array, nome) =>
  array.filter((item) => item.classeNome?.toLowerCase() === nome.toLowerCase());

/**
 * Filtra itens pelo ID do diretor.
 * @param {Array<Object>} array
 * @param {number} id
 * @returns {Array<Object>}
 */
export const getByDiretorId = (array, id) => array.filter((item) => item.diretorId === id);

/**
 * Filtra itens pelo nome do diretor (case insensitive).
 * @param {Array<Object>} array
 * @param {string} nome
 * @returns {Array<Object>}
 */
export const getByDiretorNome = (array, nome) =>
  array.filter((item) => item.diretorNome?.toLowerCase() === nome.toLowerCase());

/**
 * Filtra itens pela data de nascimento.
 * @param {Array<Object>} array
 * @param {string} data
 * @returns {Array<Object>}
 */
export const getByDtNascimento = (array, data) =>
  array.filter((item) => item.dtNascimento === data);

/**
 * Filtra itens pelo sexo (case insensitive).
 * @param {Array<Object>} array
 * @param {string} sexo
 * @returns {Array<Object>}
 */
export const getBySexo = (array, sexo) =>
  array.filter((item) => item.sexo?.toLowerCase() === sexo.toLowerCase());

/**
 * Filtra itens pelo CPF (case insensitive).
 * @param {Array<Object>} array
 * @param {string} cpf
 * @returns {Array<Object>}
 */
export const getByCpf = (array, cpf) =>
  array.filter((item) => item.cpf?.toLowerCase() === cpf.toLowerCase());

/**
 * Filtra itens pelo endereço (case insensitive).
 * @param {Array<Object>} array
 * @param {string} endereco
 * @returns {Array<Object>}
 */
export const getByEndereco = (array, endereco) =>
  array.filter((item) => item.endereco?.toLowerCase() === endereco.toLowerCase());

/**
 * Filtra itens pelo telefone.
 * @param {Array<Object>} array
 * @param {string} telefone
 * @returns {Array<Object>}
 */
export const getByTelefone = (array, telefone) =>
  array.filter((item) => item.telefone === telefone);

/* === Arrays de valores simples (ex: atoresIds) === */

/**
 * Filtra itens que contêm determinado ator ID.
 * @param {Array<Object>} array
 * @param {number} atorId
 * @returns {Array<Object>}
 */
export const getByAtoresIds = (array, atorId) =>
  array.filter((item) => item.atoresIds?.includes(atorId));

/* === Arrays de objetos (ex: dependentes) === */

/**
 * Filtra itens que possuem dependente pelo nome (case insensitive).
 * @param {Array<Object>} array
 * @param {string} nome
 * @returns {Array<Object>}
 */
export const getByDependenteNome = (array, nome) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.nome?.toLowerCase() === nome.toLowerCase())
  );

/**
 * Filtra itens que possuem dependente pela data de nascimento.
 * @param {Array<Object>} array
 * @param {string} dt
 * @returns {Array<Object>}
 */
export const getByDependenteDtNascimento = (array, dt) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.dtNascimento === dt)
  );

/**
 * Filtra itens que possuem dependente pelo sexo (case insensitive).
 * @param {Array<Object>} array
 * @param {string} sexo
 * @returns {Array<Object>}
 */
export const getByDependenteSexo = (array, sexo) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.sexo?.toLowerCase() === sexo.toLowerCase())
  );