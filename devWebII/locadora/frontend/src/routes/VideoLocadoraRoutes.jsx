import React from "react";
import { Routes, Route } from "react-router-dom";
import Home from "../pages/Home";
import NotFound from "../pages/NotFound";
import ListPage from "../pages/ListPage";
import NewPage from "../pages/NewPage";
import EditPage from "../pages/EditPage";
import ModuleWrapper from "../components/ModuleWrapper";
import AuthPage from "../pages/auth/login";

const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<AuthPage />} />
      <Route path="/home" element={<Home />} />

      {/* Cada rota que usa módulo dinâmico vai envolver o componente com o ModuleWrapper */}
      <Route
        path="/:moduleName"
        element={
          <ModuleWrapper>
            <ListPage />
          </ModuleWrapper>
        }
      />
      <Route
        path="/:moduleName/novo"
        element={
          <ModuleWrapper>
            <NewPage />
          </ModuleWrapper>
        }
      />
      <Route
        path="/:moduleName/editar/:id"
        element={
          <ModuleWrapper>
            <EditPage />
          </ModuleWrapper>
        }
      />

      <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

export default AppRoutes;
