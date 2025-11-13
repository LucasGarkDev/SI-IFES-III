import React from "react";

const SelectField = ({ name, label, options = [], value, onChange, required }) => {
	return (
		<div className="mb-3">
			<label htmlFor={name} className="form-label">
				{label}
			</label>
			<select
				id={name}
				name={name}
				className="form-select"
				value={value || ""}
				onChange={onChange}
				required={required}
			>
				<option value="">Selecione...</option>
				{options.map((opt, index) => (
					<option key={index} value={opt}>
						{opt}
					</option>
				))}
			</select>
		</div>
	);
};

export default SelectField;
