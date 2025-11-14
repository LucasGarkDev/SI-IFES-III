import React from "react";
import InputField from "./InputField";
import SelectField from "./SelectField";
import CheckboxField from "./CheckboxField";
import RadioGroupField from "./RadioGroupField";

/**
 * @component FormField
 * @description
 * Componente controlador que renderiza dinamicamente o tipo correto de campo
 * de formulário (input, select, checkbox, radio) com base na propriedade `type`.
 *
 * Atua como um wrapper para componentes mais específicos:
 * - `<InputField />`
 * - `<SelectField />`
 * - `<CheckboxField />`
 * - `<RadioGroupField />`
 *
 * @param {Object} props - Propriedades do componente.
 * @param {Object} props.field - Objeto que descreve o campo.
 * @param {string} props.field.name - Nome do campo (atributo `name` do input).
 * @param {string} props.field.label - Rótulo exibido ao lado/acima do campo.
 * @param {string} props.field.type - Tipo do campo (`text`, `number`, `select`, `checkbox`, `radio` etc.).
 * @param {Array<string>} [props.field.options] - Lista de opções (para `select` ou `radio`).
 * @param {boolean} [props.field.required=true] - Define se o campo é obrigatório.
 * @param {any} props.value - Valor atual do campo.
 * @param {Function} props.onChange - Função chamada quando o valor do campo muda.
 *
 * @returns {JSX.Element} Um componente de campo de formulário apropriado.
 */
const FormField = ({ field, value, onChange }) => {
	const { name, label, type, options, required = true } = field;

	switch (type) {
		case "select":
			return (
				<SelectField
					name={name}
					label={label}
					options={options}
					value={value}
					onChange={onChange}
					required={required}
				/>
			);

		case "radio":
			return (
				<RadioGroupField
					name={name}
					label={label}
					options={options}
					value={value}
					onChange={onChange}
					required={required}
				/>
			);

		case "checkbox":
			return (
				<CheckboxField
					name={name}
					label={label}
					checked={value}
					onChange={onChange}
					required={required}
				/>
			);

		default:
			return (
				<InputField
					name={name}
					label={label}
					type={type}
					value={value}
					onChange={onChange}
					required={required}
				/>
			);
	}
};

export default FormField;
