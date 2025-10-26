import React from "react";

const TableHeader = ({ fields }) => (
	<thead className="table-dark">
		<tr>
			{fields.map((field) => (
				<th key={field}>
					{field.replace(/_/g, " ").replace(/\b\w/g, (l) => l.toUpperCase())}
				</th>
			))}
			<th>Ações</th>
		</tr>
	</thead>
);

export default TableHeader;
