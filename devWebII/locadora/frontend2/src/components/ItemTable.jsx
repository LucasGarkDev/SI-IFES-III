import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function ItemTable({ listaItens, onEdit, onDelete }) {
  const headers = ["ID", "Nº Série", "Tipo", "Data Aquisição", "Título", "Ações"];

  const rows = listaItens.map((item) => (
    <>
      <td>{item.id}</td>
      <td>{item.numSerie}</td>
      <td>{item.tipoItem}</td>
      <td>{item.dtAquisicao}</td>
      <td>{item.tituloNome}</td>
      <td>
        <ActionButton label="Editar" variant="edit" onClick={() => onEdit(item)} />
        <ActionButton label="Excluir" variant="delete" onClick={() => onDelete(item)} />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default ItemTable;
