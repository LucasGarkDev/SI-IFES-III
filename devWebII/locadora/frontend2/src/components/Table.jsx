import React from "react";
import "../styles/table.css";

function Table({ headers, rows }) {
  return (
    <table className="retro-table">
      <thead>
        <tr>
          {headers.map((h, idx) => (
            <th key={idx}>{h}</th>
          ))}
        </tr>
      </thead>
      <tbody>
        {rows.length > 0 ? (
          rows.map((row, idx) => <tr key={idx}>{row}</tr>)
        ) : (
          <tr>
            <td colSpan={headers.length} style={{ textAlign: "center" }}>
              Nenhum registro encontrado
            </td>
          </tr>
        )}
      </tbody>
    </table>
  );
}

export default Table;
