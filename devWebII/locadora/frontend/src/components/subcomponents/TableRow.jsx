import React from "react";
import TableActions from "./TableActions";

const TableRow = ({ item, fields, onDelete }) => (
	<tr>
		{fields.map((field) => (
			<td key={field}>{item[field]}</td>
		))}
		<td>
			<TableActions item={item} onDelete={onDelete} />
		</td>
	</tr>
);

export default TableRow;
