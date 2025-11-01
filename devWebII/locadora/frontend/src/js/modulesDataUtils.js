/**
 * Utils para buscar dados nos arrays de cada módulo
 */

/* === Campos simples === */
export const getItemById = (array, id) => array.find((item) => item.id === id);

export const getByNome = (array, nome) =>
  array.filter((item) => item.nome?.toLowerCase() === nome.toLowerCase());

export const getByAno = (array, ano) => array.filter((item) => item.ano === ano);

export const getBySinopse = (array, sinopse) =>
  array.filter((item) => item.sinopse?.toLowerCase().includes(sinopse.toLowerCase()));

export const getByCategoria = (array, categoria) =>
  array.filter((item) => item.categoria?.toLowerCase() === categoria.toLowerCase());

export const getByDataDevolucao = (array, data) =>
  array.filter((item) => item.dataDevolucao === data);

export const getByPrecoDiariaCentavos = (array, preco) =>
  array.filter((item) => item.precoDiariaCentavos === preco);

export const getByNumSerie = (array, numSerie) =>
  array.filter((item) => item.numSerie?.toLowerCase() === numSerie.toLowerCase());

export const getByTipoItem = (array, tipo) =>
  array.filter((item) => item.tipoItem?.toLowerCase() === tipo.toLowerCase());

export const getByTituloId = (array, id) => array.filter((item) => item.tituloId === id);

export const getByTituloNome = (array, nome) =>
  array.filter((item) => item.tituloNome?.toLowerCase() === nome.toLowerCase());

export const getByClasseId = (array, id) => array.filter((item) => item.classeId === id);

export const getByClasseNome = (array, nome) =>
  array.filter((item) => item.classeNome?.toLowerCase() === nome.toLowerCase());

export const getByDiretorId = (array, id) => array.filter((item) => item.diretorId === id);

export const getByDiretorNome = (array, nome) =>
  array.filter((item) => item.diretorNome?.toLowerCase() === nome.toLowerCase());

export const getByDtNascimento = (array, data) =>
  array.filter((item) => item.dtNascimento === data);

export const getBySexo = (array, sexo) =>
  array.filter((item) => item.sexo?.toLowerCase() === sexo.toLowerCase());

export const getByCpf = (array, cpf) =>
  array.filter((item) => item.cpf?.toLowerCase() === cpf.toLowerCase());

export const getByEndereco = (array, endereco) =>
  array.filter((item) => item.endereco?.toLowerCase() === endereco.toLowerCase());

export const getByTelefone = (array, telefone) =>
  array.filter((item) => item.telefone === telefone);

/* === Arrays de valores simples (ex: atoresIds) === */
export const getByAtoresIds = (array, atorId) =>
  array.filter((item) => item.atoresIds?.includes(atorId));

/* === Arrays de objetos (ex: dependentes) === */
export const getByDependenteNome = (array, nome) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.nome?.toLowerCase() === nome.toLowerCase())
  );

export const getByDependenteDtNascimento = (array, dt) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.dtNascimento === dt)
  );

export const getByDependenteSexo = (array, sexo) =>
  array.filter((item) =>
    item.dependentes?.some((d) => d.sexo?.toLowerCase() === sexo.toLowerCase())
  );
