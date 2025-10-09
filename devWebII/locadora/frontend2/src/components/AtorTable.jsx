import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function AtorTable({ atores, onEdit, onDelete }) {
  const headers = ["ID", "Nome", "Ações"];

  const rows = atores.map((ator) => (
    <>
      <td>{ator.id}</td>
      <td>{ator.nome}</td>
      <td>
        <ActionButton
          label="Editar"
          variant="edit"
          onClick={() => onEdit(ator)}
        />
        <ActionButton
          label="Excluir"
          variant="delete"
          onClick={() => onDelete(ator)} // ✅ passa o ator inteiro
        />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default AtorTable;

