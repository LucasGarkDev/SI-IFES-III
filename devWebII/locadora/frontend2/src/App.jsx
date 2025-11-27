// Arquivo: locadora/frontend2/src/App.jsx
import React from "react";
import { Routes, Route } from "react-router-dom";

import ConsultarTituloPage from "./pages/ConsultarTituloPage";
import AdminLayout from "./pages/AdminLayout";

function App() {
  return (
    <Routes>
      {/* 🌟 NOVA HOME DO SISTEMA */}
      <Route path="/" element={<ConsultarTituloPage />} />

      {/* 🔐 ÁREA ADMINISTRATIVA */}
      <Route path="/admin/*" element={<AdminLayout />} />
    </Routes>
  );
}

export default App;


