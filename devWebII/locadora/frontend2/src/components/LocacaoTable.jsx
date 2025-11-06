import React from "react";
import "../styles/table.css";

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
            <td colSpan="11">Nenhum registro encontrado</td>
          </tr>
        ) : (
          locacoes.map((l) => (
            <tr key={l.id}>
              <td>{l.id}</td>
              <td>{l.clienteId}</td>
              <td>{l.itemId}</td>
              <td>{l.dataLocacao}</td>
              <td>{l.dataPrevistaDevolucao}</td>
              <td>{l.dataEfetivaDevolucao || "-"}</td>
              <td>{(l.valorCentavos / 100).toFixed(2)}</td>
              <td>{(l.multaCentavos / 100).toFixed(2)}</td>
              <td>{l.paga ? "Sim" : "Não"}</td>
              <td>{l.cancelada ? "Sim" : "Não"}</td>
              <td>
                {!l.cancelada && (
                  <>
                    <button
                      className="btn-small"
                      onClick={() => onEdit(l)}
                    >
                      Editar
                    </button>
                    {!l.dataEfetivaDevolucao && (
                      <button
                        className="btn-small yellow"
                        onClick={() => onDevolver(l.itemId)}
                      >
                        Devolver
                      </button>
                    )}
                    <button
                      className="btn-small red"
                      onClick={() => onDelete(l.id)}
                    >
                      Cancelar
                    </button>
                  </>
                )}
              </td>
            </tr>
          ))
        )}
      </tbody>
    </table>
  );
}

export default LocacaoTable;
