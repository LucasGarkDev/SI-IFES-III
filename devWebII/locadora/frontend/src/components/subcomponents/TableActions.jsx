import React from "react";
import { Link, useParams } from "react-router-dom";
import { getIDtem } from "../../js/utils";

const TableActions = ({ item, onDelete }) => {
  const { moduleName } = useParams();

  return (
    <>
      <Link
        to={`/${moduleName}/editar/${getIDtem(item)}`}
        className="btn btn-sm btn-warning me-2"
      >
        Editar
      </Link>
      <button
        onClick={() => onDelete(item)}
        className="btn btn-sm btn-danger"
      >
        Excluir
      </button>
    </>
  );
};

export default TableActions;
