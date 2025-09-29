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

function ClassesPage() {
  const [listaClasses, setListaClasses] = useState([]);
  const [classeEditando, setClasseEditando] = useState(null);

  useEffect(() => {
    fetchClasses();
  }, []);

  const fetchClasses = async () => {
    try {
      const res = await getClasses();
      setListaClasses(res.data);
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
      await updateClasse(classeAtualizada.id, classeAtualizada);
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

  return (
    <div>
      <h2>Listagem de Classes (CRUD)</h2>
      <ClasseForm onAdd={handleAdd} />
      <ClasseTable
        listaClasses={listaClasses}
        onEdit={setClasseEditando}
        onDelete={handleDelete}
      />
      <ClasseEditModal
        classe={classeEditando}
        onSave={handleSave}
        onClose={() => setClasseEditando(null)}
      />
    </div>
  );
}

export default ClassesPage;
