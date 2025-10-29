import React from "react";
import Table from "./Table";
import ActionButton from "./ui/ActionButton";

function ClienteTable({ clientes, onDelete }) {
  const headers = ["ID", "Inscrição", "Nome", "Nascimento", "Sexo", "Ativo", "Tipo", "Ações"];

  const rows = clientes.map((c) => (
    <>
      <td>{c.id}</td>
      <td>{c.numInscricao}</td>
      <td>{c.nome}</td>
      <td>{c.dtNascimento}</td>
      <td>{c.sexo}</td>
      <td>{c.estaAtivo ? "Sim" : "Não"}</td>
      <td>{c.tipoCliente}</td>
      <td>
        <ActionButton
          label="Excluir"
          variant="delete"
          onClick={() => onDelete(c)}
        />
      </td>
    </>
  ));

  return <Table headers={headers} rows={rows} />;
}

export default ClienteTable;
