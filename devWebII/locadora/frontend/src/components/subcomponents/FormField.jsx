import React from "react";

const FormField = ({ field, value, onChange }) => {
	const { name, label, type } = field;

	return (
		<div className="mb-3">
			<label htmlFor={name} className="form-label">
				{label}
			</label>
			<input
				id={name}
				name={name}
				type={type}
				className="form-control"
				value={type === "checkbox" ? undefined : value || ""}
				checked={type === "checkbox" ? value || false : undefined}
				onChange={onChange}
				required
			/>
		</div>
	);
};

export default FormField;