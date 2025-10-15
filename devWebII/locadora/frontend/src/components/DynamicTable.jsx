import React, { useState } from "react";
import { Link, useParams } from "react-router-dom";
import ConfirmModal from "./ConfirmModal";
import { extractKeys, filtrarCampos, getIDtem, getTitleItem } from "../js/utils";
import Loading from "./Loading";
import { remove } from "../service/apiFunctions";

const DynamicTable = ({ data, fields }) => {
  const [loading, setLoading] = useState(false);
  const tableFiltros = ["id", "_id"];

  if (!data || data.length === 0)
    return <p className="text-muted">Nenhum dado disponível.</p>;

  const detectedFields = fields || extractKeys(data);
  const filteredFields = filtrarCampos(tableFiltros, detectedFields);
  const { moduleName } = useParams();

  // handles for modal
  const [showModal, setShowModal] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null);
  const handleDeleteClick = (item) => {
    console.log("[DynamicTable] Solicitando exclusão de:", item);
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

  const handleCancel = () => {
    console.log("[DynamicTable] Exclusão cancelada");
    setShowModal(false);
    setSelectedItem(null);
  };

  // handles

  const tryDelete = async (item) => {
    try {
      setLoading(true);
      window.addAlert(`🗑️ Excluindo ${moduleName}...`, "warning");
      window.addAlert(`📤 Enviando requisição de exclusão...`, "info");

      await remove(moduleName, getIDtem(item));

      window.addAlert(
        `✅ ${getTitleItem(item)} removido com sucesso!`,
        "success"
      );
      console.log("[DynamicTable] Item deletado com sucesso!");
    } catch (err) {
      window.addAlert(`❌ Erro ao excluir! ${err}`, "danger");
      console.error("[DynamicTable] Erro ao deletar item:", err);
    } finally {
      window.addAlert("🏁 Processo de exclusão concluído", "success");
      setLoading(false);
    }
  };

  return (
    <>
      <table className="table table-striped table-bordered table-hover">
        <thead className="table-dark">
          <tr>
            {filteredFields.map((field) => (
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
              {filteredFields.map((field) => (
                <td key={field}>{item[field]}</td>
              ))}
              <td>
                <Link
                  to={`/${moduleName}/editar/${getIDtem(item)}`}
                  className="btn btn-sm btn-warning me-2"
                >
                  Editar
                </Link>
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

      <ConfirmModal
        show={showModal}
        title="Confirmação de exclusão"
        message={`Deseja realmente excluir o item "${getTitleItem(
          selectedItem
        )}"?`}
        onConfirm={handleConfirmDelete}
        onCancel={handleCancel}
      />

      {loading && <Loading message={`Deletando ${moduleName}`} />}
    </>
  );
};

export default DynamicTable;
