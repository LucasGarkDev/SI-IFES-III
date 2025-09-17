import React from "react";
import { Routes, Route } from "react-router-dom";
import Home from "../pages/Home.jsx";
import NotFound from "../pages/NotFound.jsx";

// Atores
import ActorList from "../pages/actor/ActorList.jsx";
import ActorForm from "../pages/actor/ActorForm.jsx";

// Classes
import ClassList from "../pages/class/ClassList.jsx";
import ClassForm from "../pages/class/ClassForm.jsx";

// Diretores
import DirectorList from "../pages/director/DirectorList.jsx";
import DirectorForm from "../pages/director/DirectorForm.jsx";

const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<Home />} />

      {/* Atores */}
      <Route path="/atores" element={<ActorList />} />
      <Route path="/atores/novo" element={<ActorForm />} />
      <Route path="/atores/editar/:id" element={<ActorForm />} />

      {/* Classes */}
      <Route path="/classes" element={<ClassList />} />
      <Route path="/classes/nova" element={<ClassForm />} />
      <Route path="/classes/editar/:id" element={<ClassForm />} />

      {/* Diretores */}
      <Route path="/diretores" element={<DirectorList />} />
      <Route path="/diretores/novo" element={<DirectorForm />} />
      <Route path="/diretores/editar/:id" element={<DirectorForm />} />

      {/* Página não encontrada */}
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

export default AppRoutes;
