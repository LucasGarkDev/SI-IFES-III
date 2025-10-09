import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function DiretorTable({ diretores, onEdit, onDelete }) {
  const headers = ["ID", "Nome", "Ações"];

  const rows = diretores.map((d) => (
    <>
      <td>{d.id}</td>
      <td>{d.nome}</td>
      <td>
        <ActionButton label="Editar" variant="edit" onClick={() => onEdit(d)} />
        <ActionButton label="Excluir" variant="delete" onClick={() => onDelete(d)} />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default DiretorTable;

