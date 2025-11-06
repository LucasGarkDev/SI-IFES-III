import React, { useEffect, useState } from "react";
import LocacaoForm from "../components/LocacaoForm";
import LocacaoTable from "../components/LocacaoTable";
import LocacaoEditModal from "../components/LocacaoEditModal";
import {
  getLocacoes,
  createLocacao,
  devolverLocacao,
  cancelarLocacao,
} from "../services/locacaoService";
import { updateLocacao } from "../services/locacaoService"; // adicionar função PUT no service

function LocacoesPage() {
  const [locacoes, setLocacoes] = useState([]);
  const [locacaoEditando, setLocacaoEditando] = useState(null);

  const fetchLocacoes = async () => {
    const res = await getLocacoes();
    setLocacoes(res.data);
  };

  useEffect(() => {
    fetchLocacoes();
  }, []);

  const handleAdd = async (locacao) => {
    try {
      await createLocacao(locacao);
      fetchLocacoes();
    } catch (err) {
      alert(err.response?.data?.message || "Erro ao registrar locação.");
    }
  };

  const handleSave = async (loc) => {
    try {
      await updateLocacao(loc.id, loc);
      setLocacaoEditando(null);
      fetchLocacoes();
    } catch (err) {
      alert(err.response?.data?.message || "Erro ao atualizar locação.");
    }
  };

  const handleDevolver = async (itemId) => {
    const numeroSerie =
        prompt(`Informe o número de série do item (ID: ${itemId}):`)?.trim();
    if (numeroSerie) {
        try {
        await devolverLocacao({ numeroSerie });
        fetchLocacoes();
        } catch (err) {
        alert(err.response?.data?.message || "Erro ao efetuar devolução.");
        }
    }
    };


  const handleDelete = async (id) => {
    if (window.confirm("Deseja cancelar esta locação?")) {
      try {
        await cancelarLocacao(id);
        fetchLocacoes();
      } catch (err) {
        alert(err.response?.data?.message || "Erro ao cancelar locação.");
      }
    }
  };

  return (
    <div className="page">
      <h2>Listagem de Locações (CRUD)</h2>
      <LocacaoForm onAdd={handleAdd} />
      <LocacaoTable
        locacoes={locacoes}
        onEdit={setLocacaoEditando}
        onDelete={handleDelete}
        onDevolver={handleDevolver}
      />
      <LocacaoEditModal
        locacao={locacaoEditando}
        onSave={handleSave}
        onClose={() => setLocacaoEditando(null)}
      />
    </div>
  );
}

export default LocacoesPage;
