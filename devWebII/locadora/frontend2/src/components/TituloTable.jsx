import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function TituloTable({ titulos, onEdit, onDelete }) {
  const headers = ["ID", "Nome", "Ano", "Categoria", "Classe", "Diretor", "Atores", "Ações"];

  const rows = titulos.map((titulo) => (
    <>
      <td>{titulo.id}</td>
      <td>{titulo.nome}</td>
      <td>{titulo.ano}</td>
      <td>{titulo.categoria}</td>
      <td>{titulo.classeNome}</td>
      <td>{titulo.diretorNome}</td>
      <td>{titulo.atoresNomes?.join(", ")}</td>
      <td>
        <ActionButton label="Editar" variant="edit" onClick={() => onEdit(titulo)} />
        <ActionButton label="Excluir" variant="delete" onClick={() => onDelete(titulo)} />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default TituloTable;
