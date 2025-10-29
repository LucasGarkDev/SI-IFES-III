import React, { useState, useEffect } from "react";

function TituloEditModal({ titulo, onSave, onClose }) {
  const [nome, setNome] = useState("");
  const [ano, setAno] = useState("");
  const [sinopse, setSinopse] = useState("");
  const [categoria, setCategoria] = useState("");
  const [classeId, setClasseId] = useState("");
  const [diretorId, setDiretorId] = useState("");
  const [atoresIds, setAtoresIds] = useState("");

  useEffect(() => {
    if (titulo) {
      setNome(titulo.nome);
      setAno(titulo.ano);
      setSinopse(titulo.sinopse);
      setCategoria(titulo.categoria);
      setClasseId(titulo.classeId);
      setDiretorId(titulo.diretorId);
      setAtoresIds(titulo.atoresIds?.join(", "));
    }
  }, [titulo]);

  const handleSubmit = (e) => {
    e.preventDefault();
    const payload = {
      ...titulo,
      nome,
      ano: parseInt(ano, 10),
      sinopse,
      categoria,
      classeId: parseInt(classeId, 10),
      diretorId: parseInt(diretorId, 10),
      atoresIds: atoresIds.split(",").map((id) => parseInt(id.trim(), 10)),
    };
    onSave(payload);
  };

  if (!titulo) return null;

  return (
    <div className="modal">
      <div className="modal-content box">
        <h3>Editar Título</h3>
        <form onSubmit={handleSubmit}>
          <label>
            Nome:
            <input type="text" value={nome} onChange={(e) => setNome(e.target.value)} required />
          </label>
          <label>
            Ano:
            <input type="number" value={ano} onChange={(e) => setAno(e.target.value)} required />
          </label>
          <label>
            Categoria:
            <input type="text" value={categoria} onChange={(e) => setCategoria(e.target.value)} required />
          </label>
          <label>
            Sinopse:
            <textarea value={sinopse} onChange={(e) => setSinopse(e.target.value)} />
          </label>
          <label>
            ID Classe:
            <input type="number" value={classeId} onChange={(e) => setClasseId(e.target.value)} required />
          </label>
          <label>
            ID Diretor:
            <input type="number" value={diretorId} onChange={(e) => setDiretorId(e.target.value)} required />
          </label>
          <label>
            IDs Atores:
            <input type="text" value={atoresIds} onChange={(e) => setAtoresIds(e.target.value)} required />
          </label>
          <button type="submit">Salvar</button>
          <button type="button" onClick={onClose}>Cancelar</button>
        </form>
      </div>
    </div>
  );
}

export default TituloEditModal;
