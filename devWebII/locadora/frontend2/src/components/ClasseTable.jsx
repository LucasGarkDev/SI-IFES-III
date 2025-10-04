import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function ClasseTable({ listaClasses, onEdit, onDelete }) {
  const headers = ["ID", "Nome", "Valor (R$)", "Data de Devolução", "Ações"];

  const rows = listaClasses.map((classe) => (
    <>
      <td>{classe.id}</td>
      <td>{classe.nome}</td>
      <td>
        {classe.precoDiariaCentavos != null
          ? (classe.precoDiariaCentavos / 100).toFixed(2)
          : "—"}
      </td>
      <td>{classe.dataDevolucao || "—"}</td>
      <td>
        <ActionButton
          label="Editar"
          variant="edit"
          onClick={() => onEdit(classe)}
        />
        <ActionButton
          label="Excluir"
          variant="delete"
          onClick={() => onDelete(classe.id)}
        />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default ClasseTable;
