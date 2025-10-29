import React, { useState, useEffect } from "react";
import {
  getItens,
  createItem,
  updateItem,
  deleteItem,
} from "../services/itemService";
import ItemForm from "../components/ItemForm";
import ItemTable from "../components/ItemTable";
import ItemEditModal from "../components/ItemEditModal";
import ConfirmModal from "../components/ui/ConfirmModal";

function ItensPage() {
  const [listaItens, setListaItens] = useState([]);
  const [itemEditando, setItemEditando] = useState(null);
  const [itemExcluindo, setItemExcluindo] = useState(null);

  useEffect(() => {
    fetchItens();
  }, []);

  const fetchItens = async () => {
    try {
      const res = await getItens();
      setListaItens(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar itens:", err);
    }
  };

  const handleAdd = async (novoItem) => {
    try {
      await createItem(novoItem);
      fetchItens();
    } catch (err) {
      console.error("Erro ao adicionar item:", err);
    }
  };

  const handleSave = async (itemAtualizado) => {
    try {
      await updateItem(itemAtualizado.id, itemAtualizado);
      setItemEditando(null);
      fetchItens();
    } catch (err) {
      console.error("Erro ao atualizar item:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteItem(id);
      fetchItens();
    } catch (err) {
      console.error("Erro ao excluir item:", err);
    }
  };

  const confirmarExclusao = (item) => setItemExcluindo(item);

  const confirmarDelete = async () => {
    if (itemExcluindo) {
      await handleDelete(itemExcluindo.id);
      setItemExcluindo(null);
    }
  };

  return (
    <div>
      <h2>Listagem de Itens (CRUD)</h2>
      <ItemForm onAdd={handleAdd} />
      <ItemTable
        listaItens={listaItens}
        onEdit={setItemEditando}
        onDelete={confirmarExclusao}
      />
      <ItemEditModal
        item={itemEditando}
        onSave={handleSave}
        onClose={() => setItemEditando(null)}
      />
      <ConfirmModal
        isOpen={!!itemExcluindo}
        onConfirm={confirmarDelete}
        onCancel={() => setItemExcluindo(null)}
        itemName={itemExcluindo?.numSerie}
      />
    </div>
  );
}

export default ItensPage;
