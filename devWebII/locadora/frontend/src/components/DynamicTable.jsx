import React from "react";

const DynamicTable = ({ data }) => {
  if (!data || data.length === 0) {
    return <p>Nenhum dado disponível</p>;
  }

  // Pega as chaves do primeiro objeto para gerar as colunas
  const columns = Object.keys(data[0]);

  return (
    <table border="1" cellPadding="5" style={{ borderCollapse: "collapse", width: "100%" }}>
      <thead>
        <tr>
          {columns.map((col) => (
            <th key={col}>{col}</th>
          ))}
        </tr>
      </thead>
      <tbody>
        {data.map((row, rowIndex) => (
          <tr key={rowIndex}>
            {columns.map((col) => (
              <td key={col}>{row[col]}</td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
};

export default DynamicTable;