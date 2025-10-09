// src/components/DynamicTable.jsx
import React, { useState } from "react";
import { Link, useParams } from "react-router-dom";
import ConfirmModal from "./ConfirmModal";
import { remove } from "../service/api";
import { getTitleItem } from "../js/utils";
import Loading from "./Loading";

const DynamicTable = ({ data, fields }) => {
  const [showModal, setShowModal] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null);
  const [loading, setLoading] = useState(false); // Estado para controlar o overlay

  if (!data || data.length === 0)
    return <p className="text-muted">Nenhum dado disponível.</p>;

  // pega os campos dinamicamente ou usa os fornecidos
  const detectedFields =
    fields || Object.keys(data[0]).filter((f) => f !== "id" && f !== "_id");

  // pega o moduleName da URL (ator, filme, etc.)
  const { moduleName } = useParams();

  const handleDeleteClick = (item) => {
    console.log("[DYNAMIC TABLE] Solicitando exclusão de:", item);
    setSelectedItem(item);
    setShowModal(true);
  };

  const handleConfirmDelete = () => {
    if (selectedItem) {
      tryDelete(selectedItem);
    }
    setShowModal(false);
    setSelectedItem(null);
  };

  const tryDelete = async (data) => {
    console.log("[DYNAMIC TABLE] Tentando deletar item...");
    try {
      setLoading(true); // Ativa o overlay
      // usa moduleConfig.name como endpoint
      await remove(moduleName, data._id);
      console.log("[DYNAMIC TABLE] Item deletado com sucesso!");
    } catch (err) {
      console.error("[DYNAMIC TABLE] Erro ao deletar item:", err);
    } finally {
      setLoading(false); // Desativa o overlay mesmo se der erro
    }
  };

  const handleCancel = () => {
    console.log("[DYNAMIC TABLE] Exclusão cancelada");
    setShowModal(false);
    setSelectedItem(null);
  };

  return (
    <>
      <table className="table table-striped table-bordered table-hover">
        <thead className="table-dark">
          <tr>
            {detectedFields.map((field) => (
              <th key={field}>
                {field
                  .replace(/_/g, " ")
                  .replace(/\b\w/g, (l) => l.toUpperCase())}
              </th>
            ))}
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          {data.map((item, idx) => (
            <tr key={idx}>
              {detectedFields.map((field) => (
                <td key={field}>{item[field]}</td>
              ))}
              <td>
                {/* Editar -> vai para rota dinâmica */}
                <Link
                  to={`/${moduleName}/editar/${item.id || item._id}`}
                  className="btn btn-sm btn-warning me-2"
                >
                  Editar
                </Link>

                {/* Excluir -> abre modal */}
                <button
                  onClick={() => handleDeleteClick(item)}
                  className="btn btn-sm btn-danger"
                >
                  Excluir
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      {/* Modal de confirmação */}
      <ConfirmModal
        show={showModal}
        title="Confirmação de exclusão"
        message={`Deseja realmente excluir o item "${getTitleItem(
          selectedItem
        )}"?`}
        onConfirm={handleConfirmDelete}
        onCancel={handleCancel}
      />

      {/* Overlay de Loading */}
      {loading && <Loading message={`Deletando ${moduleName}`} />}
    </>
  );
};

export default DynamicTable;

// example usage:
// <DynamicTable
//   data={moduleConfig.data}
//   fields={moduleConfig.fields}
//   onDelete={(item) => {
//     console.log("Excluir:", item);
//   }}
// />
