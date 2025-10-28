import React, { useState, useCallback } from "react";
import AutoDismissAlert from "./subcomponents/AutoDismissAlert";

/**
 * Gera um ID único e seguro
 * Combina timestamp + número aleatório
 */
const generateUniqueId = () => `${Date.now()}-${Math.random().toString(36).substring(2, 9)}`;

/**
 * Gerencia uma fila de alertas visuais.
 * @returns {JSX.Element}
 */
const AlertManager = () => {
  const [alerts, setAlerts] = useState([]);

  /**
   * Adiciona um novo alerta com duração variável.
   * @param {string} message - Mensagem do alerta.
   * @param {"success"|"danger"|"info"|"warning"} type - Tipo do alerta.
   */
  const addAlert = useCallback((message, type = "info") => {
    const id = generateUniqueId();

    // ⏳ duração personalizada por tipo
    const durations = {
      success: 5000,
      info: 6000,
      warning: 7000,
      danger: 8000,
    };

    const duration = durations[type] || 5000;

    // adiciona o alerta
    setAlerts((prev) => [...prev, { id, message, type, duration }]);

    // remove automaticamente após o tempo
    setTimeout(() => {
      setAlerts((prev) => prev.filter((a) => a.id !== id));
    }, duration);
  }, []);

  // Expor globalmente (temporário)
  window.addAlert = addAlert;

  return (
    <div className="alert-container">
      {alerts.map((alert) => (
        <AutoDismissAlert
          key={alert.id}
          message={alert.message}
          type={alert.type}
          duration={alert.duration}
        />
      ))}
    </div>
  );
};

export default AlertManager;
