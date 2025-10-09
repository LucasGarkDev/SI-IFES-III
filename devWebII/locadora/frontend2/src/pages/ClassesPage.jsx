import React, { useState, useEffect } from "react";
import {
  getClasses,
  createClasse,
  updateClasse,
  deleteClasse,
} from "../services/classeService";
import ClasseForm from "../components/ClasseForm";
import ClasseTable from "../components/ClasseTable";
import ClasseEditModal from "../components/ClasseEditModal";
import ConfirmModal from "../components/ui/ConfirmModal";

function ClassesPage() {
  const [listaClasses, setListaClasses] = useState([]);
  const [classeEditando, setClasseEditando] = useState(null);
  const [classeExcluindo, setClasseExcluindo] = useState(null);

  useEffect(() => {
    fetchClasses();
  }, []);

  const fetchClasses = async () => {
    try {
      const res = await getClasses();
      setListaClasses(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar classes:", err);
    }
  };

  const handleAdd = async (novaClasse) => {
    try {
      await createClasse(novaClasse);
      fetchClasses();
    } catch (err) {
      console.error("Erro ao adicionar classe:", err);
    }
  };

  const handleSave = async (classeAtualizada) => {
    try {
      const payload = {
        id: classeAtualizada.id,
        nome: classeAtualizada.nome.trim(),
        precoDiariaCentavos: classeAtualizada.precoDiariaCentavos,
        dataDevolucao: classeAtualizada.dataDevolucao,
        ativo: classeAtualizada.ativo ?? true,
      };
      await updateClasse(classeAtualizada.id, payload);
      setClasseEditando(null);
      fetchClasses();
    } catch (err) {
      console.error("Erro ao atualizar classe:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteClasse(id);
      fetchClasses();
    } catch (err) {
      console.error("Erro ao excluir classe:", err);
    }
  };

  const confirmarExclusao = (classe) => {
    setClasseExcluindo(classe);
  };

  const confirmarDelete = async () => {
    if (classeExcluindo) {
      await handleDelete(classeExcluindo.id);
      setClasseExcluindo(null);
    }
  };

  return (
    <div>
      <h2>Listagem de Classes (CRUD)</h2>
      <ClasseForm onAdd={handleAdd} />
      <ClasseTable
        listaClasses={listaClasses}
        onEdit={setClasseEditando}
        onDelete={confirmarExclusao}
      />
      <ClasseEditModal
        classe={classeEditando}
        onSave={handleSave}
        onClose={() => setClasseEditando(null)}
      />
      <ConfirmModal
        isOpen={!!classeExcluindo}
        onConfirm={confirmarDelete}
        onCancel={() => setClasseExcluindo(null)}
        itemName={classeExcluindo?.nome}
      />
    </div>
  );
}

export default ClassesPage;
