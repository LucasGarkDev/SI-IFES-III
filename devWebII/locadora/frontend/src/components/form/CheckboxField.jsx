import React from "react";

const CheckboxField = ({ name, label, checked, onChange, required }) => {
	return (
		<div className="form-check mb-3">
			<input
				className="form-check-input"
				type="checkbox"
				id={name}
				name={name}
				checked={checked || false}
				onChange={onChange}
				required={required}
			/>
			<label className="form-check-label" htmlFor={name}>
				{label}
			</label>
		</div>
	);
};

export default CheckboxField;
