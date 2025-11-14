import React from "react";
import "../styles/table.css";
import ActionButton from "./ui/ActionButton";

function LocacaoTable({ locacoes, onEdit, onDelete, onDevolver }) {
  return (
    <table className="retro-table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Cliente</th>
          <th>Item</th>
          <th>Data Locação</th>
          <th>Prevista</th>
          <th>Efetiva</th>
          <th>Valor (R$)</th>
          <th>Multa (R$)</th>
          <th>Paga</th>
          <th>Cancelada</th>
          <th>Ações</th>
        </tr>
      </thead>

      <tbody>
        {locacoes.length === 0 ? (
          <tr>
            <td colSpan="11" style={{ textAlign: "center" }}>
              Nenhum registro encontrado
            </td>
          </tr>
        ) : (
          locacoes.map((l) => (
            <tr key={l.id}>
              <td>{l.id}</td>
              <td>{l.cliente?.nome || `Cliente #${l.clienteId}`}</td>
              <td>
                {l.item
                  ? `${l.item.numSerie} (${l.item.tipoItem})`
                  : `Item #${l.itemId}`}
              </td>
              <td>{l.dataLocacao}</td>
              <td>{l.dataPrevistaDevolucao}</td>
              <td>{l.dataEfetivaDevolucao || "-"}</td>
              <td>{(l.valorCentavos / 100).toFixed(2)}</td>
              <td>{(l.multaCentavos / 100).toFixed(2)}</td>
              <td>{l.paga ? "Sim" : "Não"}</td>
              <td>{l.cancelada ? "Sim" : "Não"}</td>
              <td>
                <ActionButton label="Editar" variant="edit" onClick={() => onEdit(l)} />
                {!l.dataEfetivaDevolucao && (
                  <ActionButton
                    label="Devolver"
                    variant="info"
                    onClick={() => onDevolver(l)} // 🔧 Agora só chama o callback da página
                  />
                )}
                <ActionButton
                  label="Cancelar"
                  variant="delete"
                  onClick={() => onDelete(l.id)}
                />
              </td>
            </tr>
          ))
        )}
      </tbody>
    </table>
  );
}

export default LocacaoTable;
