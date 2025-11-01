import React, { useState } from "react";
import { extractKeys, filtrarCampos, getRandomInt, getTitleItem } from "../js/utils";
import ConfirmModal from "./ConfirmModal";
import { remove } from "../service/apiFunctions";
import TableHeader from "./subcomponents/TableHeader";
import TableRow from "./subcomponents/TableRow";
import Loading from "./subcomponents/Loading";


const DynamicTable = ({ moduleConfig, data, fields }) => {
  const [loading, setLoading] = useState(false);
  const [showModal, setShowModal] = useState(false);
  const [selectedItem, setSelectedItem] = useState(null);
  const path = moduleConfig.label.toLowerCase();
  const errorMessages = moduleConfig.errorMessages;

  const tableFiltros = ["id", "_id"];

  if (!data || data.length === 0) {
    const msg = errorMessages[getRandomInt(errorMessages.length)];
    return <h2>{msg}</h2>;
  }

  const detectedFields = fields || extractKeys(data);
  const filteredFields = filtrarCampos(tableFiltros, detectedFields);

  const handleDeleteClick = (item) => {
    setSelectedItem(item);
    setShowModal(true);
  };

  const handleConfirmDelete = async () => {
    if (selectedItem) {
      await tryDelete(selectedItem);
    }
    setShowModal(false);
    setSelectedItem(null);
  };

  const handleCancel = () => {
    setShowModal(false);
    setSelectedItem(null);
  };

  const tryDelete = async (item) => {
    try {
      setLoading(true);
      window.addAlert(`🗑️ Excluindo item...`, "warning");
      await remove(path, item.id);
      window.addAlert(`✅ ${getTitleItem(item)} removido com sucesso!`, "success");
    } catch (err) {
      window.addAlert(`❌ Erro ao excluir! ${err}`, "danger");
    } finally {
      await moduleConfig.syncData();
      setLoading(false);
    }
  };

  return (
    <>
      <table className="table table-striped table-bordered table-hover">
        <TableHeader fields={filteredFields} />
        <tbody>
          {data.map((item, idx) => (
            <TableRow
              key={idx}
              item={item}
              fields={filteredFields}
              onDelete={handleDeleteClick}
            />
          ))}
        </tbody>
      </table>

      <ConfirmModal
        show={showModal}
        title="Confirmação de exclusão"
        message={`Deseja realmente excluir o item "${getTitleItem(selectedItem)}"?`}
        onConfirm={handleConfirmDelete}
        onCancel={handleCancel}
      />

      {loading && <Loading message="Processando exclusão..." />}
    </>
  );
};

export default DynamicTable;