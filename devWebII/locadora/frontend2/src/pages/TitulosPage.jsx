import React, { useState, useEffect } from "react";
import {
  getTitulos,
  createTitulo,
  updateTitulo,
  deleteTitulo,
} from "../services/tituloService";
import TituloForm from "../components/TituloForm";
import TituloTable from "../components/TituloTable";
import TituloEditModal from "../components/TituloEditModal";
import ConfirmModal from "../components/ui/ConfirmModal";

function TitulosPage() {
  const [titulos, setTitulos] = useState([]);
  const [tituloEditando, setTituloEditando] = useState(null);
  const [tituloExcluindo, setTituloExcluindo] = useState(null);

  useEffect(() => {
    fetchTitulos();
  }, []);

  const fetchTitulos = async () => {
    try {
      const res = await getTitulos();
      setTitulos(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar títulos:", err);
    }
  };

  const handleAdd = async (novoTitulo) => {
    try {
      await createTitulo(novoTitulo);
      fetchTitulos();
    } catch (err) {
      console.error("Erro ao adicionar título:", err);
    }
  };

  const handleSave = async (tituloAtualizado) => {
    try {
      await updateTitulo(tituloAtualizado.id, tituloAtualizado);
      setTituloEditando(null);
      fetchTitulos();
    } catch (err) {
      console.error("Erro ao atualizar título:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteTitulo(id);
      fetchTitulos();
    } catch (err) {
      console.error("Erro ao excluir título:", err);
    }
  };

  const confirmarExclusao = (titulo) => setTituloExcluindo(titulo);
  const confirmarDelete = async () => {
    if (tituloExcluindo) {
      await handleDelete(tituloExcluindo.id);
      setTituloExcluindo(null);
    }
  };

  return (
    <div>
      <h2>Listagem de Títulos (CRUD)</h2>
      <TituloForm onAdd={handleAdd} />
      <TituloTable
        titulos={titulos}
        onEdit={setTituloEditando}
        onDelete={confirmarExclusao}
      />
      <TituloEditModal
        titulo={tituloEditando}
        onSave={handleSave}
        onClose={() => setTituloEditando(null)}
      />
      <ConfirmModal
        isOpen={!!tituloExcluindo}
        onConfirm={confirmarDelete}
        onCancel={() => setTituloExcluindo(null)}
        itemName={tituloExcluindo?.nome}
      />
    </div>
  );
}

export default TitulosPage;
