import React from "react";

const InputField = ({
	name,
	label,
	type = "text",
	value,
	onChange,
	required,
}) => {
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
				required={required}
			/>
		</div>
	);
};

export default InputField;
