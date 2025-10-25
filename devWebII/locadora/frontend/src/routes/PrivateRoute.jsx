// src/components/PrivateRoute.jsx
import React, { useContext } from "react";
import { Navigate } from "react-router-dom";
import { AppContext } from "../components/AppContext";

/**
 * Componente que protege rotas para usuários logados
 */
const PrivateRoute = ({ children }) => {
	const { userLoged } = useContext(AppContext);
	if (!userLoged) return <Navigate to="/" replace />;
	return children;
};

export default PrivateRoute;
