// src/components/ErrorBoundary.jsx
import React from "react";
import { errorMessages } from "./ModuleWrapper";

class ErrorBoundary extends React.Component {
	constructor(props) {
		super(props);
		this.state = { hasError: false, error: null };
	}

	static getDerivedStateFromError(error) {
		// Atualiza o estado para renderizar fallback UI
		return { hasError: true, error };
	}

	componentDidCatch(error, errorInfo) {
		// Você pode logar o erro em um serviço externo
		console.error("[ErrorBoundary] Erro capturado:", error, errorInfo);
	}

	render() {
		if (this.state.hasError) {
			const msg =
				errorMessages[Math.floor(Math.random() * errorMessages.length)];
			return (
				<div className="alert alert-danger p-4">
					<h2>{msg} — algo deu errado ao carregar este módulo.</h2>
					<pre style={{ whiteSpace: "pre-wrap", marginTop: "1rem" }}>
						{this.state.error?.toString()}
					</pre>
				</div>
			);
		}

		return this.props.children;
	}
}

export default ErrorBoundary;
