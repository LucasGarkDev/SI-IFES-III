import React, { useEffect, useState } from "react";
import LocacaoForm from "../components/LocacaoForm";
import LocacaoTable from "../components/LocacaoTable";
import LocacaoEditModal from "../components/LocacaoEditModal";
import LocacaoDevolucaoModal from "../components/LocacaoDevolucaoModal";

import {
  getLocacoes,
  createLocacao,
  devolverLocacao,
  cancelarLocacao,
  updateLocacao,
} from "../services/locacaoService";

function LocacoesPage() {
  const [locacoes, setLocacoes] = useState([]);
  const [locacaoEditando, setLocacaoEditando] = useState(null);
  const [locacaoDevolvendo, setLocacaoDevolvendo] = useState(null); // 💡 nova state p/ modal de devolução

  // ============================
  // Buscar todas as locações
  // ============================
  const fetchLocacoes = async () => {
    try {
      const res = await getLocacoes();
      setLocacoes(res.data);
    } catch (err) {
      console.error("Erro ao buscar locações:", err);
    }
  };

  useEffect(() => {
    fetchLocacoes();
  }, []);

  // ============================
  // Criar nova locação
  // ============================
  const handleAdd = async (locacao) => {
    try {
      await createLocacao(locacao);
      fetchLocacoes();
    } catch (err) {
      alert(err.response?.data?.message || "Erro ao registrar locação.");
    }
  };

  // ============================
  // Salvar edição
  // ============================
  const handleSave = async (loc) => {
    try {
      await updateLocacao(loc.id, loc);
      setLocacaoEditando(null);
      fetchLocacoes();
    } catch (err) {
      alert(err.response?.data?.message || "Erro ao atualizar locação.");
    }
  };

  // ============================
  // Devolução com modal
  // ============================
  const handleDevolver = (locacao) => {
    setLocacaoDevolvendo(locacao); // abre o modal de devolução
  };

  const handleConfirmDevolucao = async (dados) => {
    try {
      // itemId pode vir de dois jeitos: do objeto item (quando veio aninhado) ou direto do DTO da locação
      const itemId = dados?.item?.id ?? dados?.itemId;
      if (!itemId) {
        alert("Falha: itemId não encontrado para devolução.");
        return;
      }

      // normaliza "1,23" -> 1.23 e garante número
      const multa = Number(String(dados?.multa ?? 0).toString().replace(',', '.')) || 0;

      await devolverLocacao({ itemId, multa });
      setLocacaoDevolvendo(null);
      fetchLocacoes();
    } catch (err) {
      console.error("Erro ao devolver:", err);
      alert(err.response?.data?.message || "Ocorreu um erro inesperado no servidor.");
    }
  };
  // ============================
  // Cancelar locação
  // ============================
  const handleDelete = async (id) => {
    if (window.confirm("Deseja cancelar esta locação?")) {
      try {
        await cancelarLocacao(id);
        fetchLocacoes();
      } catch (err) {
        alert(err.response?.data?.message || "Erro ao cancelar locação.");
        console.error("Erro ao cancelar locação:", err);
      }
    }
  };

  // ============================
  // Renderização
  // ============================
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

      {/* 💡 Novo modal de devolução */}
      <LocacaoDevolucaoModal
        isOpen={!!locacaoDevolvendo}
        locacao={locacaoDevolvendo}
        onConfirm={handleConfirmDevolucao}
        onClose={() => setLocacaoDevolvendo(null)}
      />
    </div>
  );
}

export default LocacoesPage;
