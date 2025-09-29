import React, { useState, useEffect } from "react";
import {
  getDiretores,
  createDiretor,
  updateDiretor,
  deleteDiretor,
} from "../services/diretorService";
import DiretorForm from "../components/DiretorForm";
import DiretorTable from "../components/DiretorTable";
import DiretorEditModal from "../components/DiretorEditModal";

function DiretoresPage() {
  const [diretores, setDiretores] = useState([]);
  const [diretorEditando, setDiretorEditando] = useState(null);

  useEffect(() => {
    fetchDiretores();
  }, []);

  const fetchDiretores = async () => {
    try {
      const res = await getDiretores();
      setDiretores(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar diretores:", err);
    }
  };


  const handleAdd = async (diretor) => {
    try {
      await createDiretor(diretor);
      fetchDiretores();
    } catch (err) {
      console.error("Erro ao adicionar diretor:", err);
    }
  };

  const handleSave = async (diretorAtualizado) => {
    try {
      await updateDiretor(diretorAtualizado.id, diretorAtualizado);
      setDiretorEditando(null);
      fetchDiretores();
    } catch (err) {
      console.error("Erro ao atualizar diretor:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteDiretor(id);
      fetchDiretores();
    } catch (err) {
      console.error("Erro ao excluir diretor:", err);
    }
  };

  return (
    <div>
      <h2>Listagem de Diretores (CRUD)</h2>
      <DiretorForm onAdd={handleAdd} />
      <DiretorTable
        diretores={diretores}
        onEdit={setDiretorEditando}
        onDelete={handleDelete}
      />
      <DiretorEditModal
        diretor={diretorEditando}
        onSave={handleSave}
        onClose={() => setDiretorEditando(null)}
      />
    </div>
  );
}

export default DiretoresPage;
