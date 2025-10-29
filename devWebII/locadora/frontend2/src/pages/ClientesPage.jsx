import React, { useState, useEffect } from "react";
import {
  getClientes,
  createSocio,
  deleteCliente,
} from "../services/clienteService";
import ClienteForm from "../components/ClienteForm";
import ClienteTable from "../components/ClienteTable";
import ConfirmModal from "../components/ui/ConfirmModal";

function ClientesPage() {
  const [clientes, setClientes] = useState([]);
  const [clienteExcluindo, setClienteExcluindo] = useState(null);

  useEffect(() => {
    fetchClientes();
  }, []);

  const fetchClientes = async () => {
    try {
      const res = await getClientes();
      setClientes(res.data.content);
    } catch (err) {
      console.error("Erro ao carregar clientes:", err);
    }
  };

  const handleAdd = async (novoSocio) => {
    try {
      await createSocio(novoSocio);
      fetchClientes();
    } catch (err) {
      console.error("Erro ao adicionar sócio:", err);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteCliente(id);
      fetchClientes();
    } catch (err) {
      console.error("Erro ao excluir cliente:", err);
    }
  };

  const confirmarExclusao = (c) => setClienteExcluindo(c);
  const confirmarDelete = async () => {
    if (clienteExcluindo) {
      await handleDelete(clienteExcluindo.id);
      setClienteExcluindo(null);
    }
  };

  return (
    <div>
      <h2>Listagem de Clientes (CRUD)</h2>
      <ClienteForm onAdd={handleAdd} />
      <ClienteTable clientes={clientes} onDelete={confirmarExclusao} />
      <ConfirmModal
        isOpen={!!clienteExcluindo}
        onConfirm={confirmarDelete}
        onCancel={() => setClienteExcluindo(null)}
        itemName={clienteExcluindo?.nome}
      />
    </div>
  );
}

export default ClientesPage;
