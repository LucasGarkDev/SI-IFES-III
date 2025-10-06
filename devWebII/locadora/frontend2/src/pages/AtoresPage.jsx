import React, { useState, useEffect } from "react";
import {
  getAtores,
  createAtor,
  updateAtor,
  deleteAtor,
} from "../services/atorService";
import AtorForm from "../components/AtorForm";
import AtorTable from "../components/AtorTable";
import AtorEditModal from "../components/AtorEditModal";
import ConfirmModal from "../components/ui/ConfirmModal";

function AtoresPage() {
  const [atores, setAtores] = useState([]);
  const [atorEditando, setAtorEditando] = useState(null);
  const [atorExcluindo, setAtorExcluindo] = useState(null);

  useEffect(() => {
    fetchAtores();
  }, []);

  const fetchAtores = async () => {
    try {
      const res = await getAtores();
      setAtores(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar atores:", err);
    }
  };

  const handleAdd = async (ator) => {
    try {
      await createAtor(ator);
      fetchAtores();
    } catch (err) {
      console.error("Erro ao adicionar ator:", err);
    }
  };

  const handleSave = async (atorAtualizado) => {
    try {
      await updateAtor(atorAtualizado.id, atorAtualizado);
      setAtorEditando(null);
      fetchAtores();
    } catch (err) {
      console.error("Erro ao atualizar ator:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteAtor(id);
      fetchAtores();
    } catch (err) {
      console.error("Erro ao excluir ator:", err);
    }
  };

  const confirmarExclusao = (ator) => {
    setAtorExcluindo(ator);
  };

  const confirmarDelete = async () => {
    if (atorExcluindo) {
      await handleDelete(atorExcluindo.id);
      setAtorExcluindo(null);
    }
  };

  return (
    <div>
      <h2>Listagem de Atores (CRUD)</h2>
      <AtorForm onAdd={handleAdd} />
      <AtorTable atores={atores} onEdit={setAtorEditando} onDelete={confirmarExclusao} />
      <AtorEditModal
        ator={atorEditando}
        onSave={handleSave}
        onClose={() => setAtorEditando(null)}
      />
      <ConfirmModal
        isOpen={!!atorExcluindo}
        onConfirm={confirmarDelete}
        onCancel={() => setAtorExcluindo(null)}
        itemName={atorExcluindo?.nome}
      />
    </div>
  );
}

export default AtoresPage;
