import React, { useState, useEffect } from "react";
import "../../styles/InputField.css";

function SelectModal({ isOpen, title, fetchItems, onSelect, onClose }) {
  const [items, setItems] = useState([]);
  const [filtro, setFiltro] = useState("");

  useEffect(() => {
    if (isOpen) carregarItens();
  }, [isOpen]);

  const carregarItens = async () => {
    try {
      const res = await fetchItems();
      const content = res.data?.content || res.data || [];
      setItems(content);
    } catch (err) {
      console.error("Erro ao carregar itens:", err);
    }
  };

  if (!isOpen) return null;

  // Filtro genérico para nome, numSerie ou tituloNome
  const itensFiltrados = items.filter((i) => {
    const termo = filtro.toLowerCase();
    return (
      i.nome?.toLowerCase().includes(termo) ||
      i.numSerie?.toLowerCase().includes(termo) ||
      i.tituloNome?.toLowerCase().includes(termo)
    );
  });

  // Função para determinar o texto que será exibido
  const getLabel = (i) => {
    if (i.nome) return i.nome;
    if (i.numSerie && i.tituloNome)
      return `${i.numSerie} — ${i.tituloNome} (${i.tipoItem || ""})`;
    if (i.numSerie) return i.numSerie;
    if (i.tituloNome) return i.tituloNome;
    return `ID ${i.id}`;
  };

  return (
    <div className="modal-overlay">
      <div className="modal-box">
        <h3>{title}</h3>

        <div className="input-field" style={{ marginBottom: "8px" }}>
          <label>Pesquisar:</label>
          <input
            type="text"
            value={filtro}
            onChange={(e) => setFiltro(e.target.value)}
            placeholder="Digite o termo..."
          />
        </div>

        <div
          style={{
            border: "1px solid #000",
            backgroundColor: "#fff",
            maxHeight: "250px",
            overflowY: "auto",
            fontFamily: "Courier New, monospace",
            fontSize: "0.9rem",
          }}
        >
          {itensFiltrados.length > 0 ? (
            itensFiltrados.map((i) => (
              <div
                key={i.id}
                onClick={() => {
                  onSelect(i);
                  onClose();
                }}
                style={{
                  padding: "4px 6px",
                  borderBottom: "1px dashed #000",
                  cursor: "pointer",
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.background = "#000";
                  e.currentTarget.style.color = "#0f0";
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.background = "#fff";
                  e.currentTarget.style.color = "#000";
                }}
              >
                <strong>{getLabel(i)}</strong>
              </div>
            ))
          ) : (
            <p style={{ textAlign: "center", margin: "8px 0" }}>
              Nenhum registro encontrado.
            </p>
          )}
        </div>

        <div style={{ marginTop: "10px", textAlign: "right" }}>
          <button
            className="btn-select"
            style={{ border: "1px solid #000" }}
            onClick={onClose}
          >
            Fechar
          </button>
        </div>
      </div>
    </div>
  );
}

export default SelectModal;
