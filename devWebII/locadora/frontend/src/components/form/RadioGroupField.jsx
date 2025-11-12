import React from "react";

const RadioGroupField = ({ name, label, options = [], value, onChange, required }) => {
	return (
		<div className="mb-3">
			<label className="form-label d-block">{label}</label>
			{options.map((opt, index) => (
				<div className="form-check form-check-inline" key={index}>
					<input
						className="form-check-input"
						type="radio"
						id={`${name}-${opt}`}
						name={name}
						value={opt}
						checked={value === opt}
						onChange={onChange}
						required={required}
					/>
					<label className="form-check-label" htmlFor={`${name}-${opt}`}>
						{opt}
					</label>
				</div>
			))}
		</div>
	);
};

export default RadioGroupField;
