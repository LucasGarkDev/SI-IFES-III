// src/routes/VideoLocadoraRoutes.jsx
import React from "react";
import { Routes, Route } from "react-router-dom";
import Home from "../pages/Home";
import NotFound from "../pages/NotFound";
import ListPage from "../pages/ListPage";
import NewPage from "../pages/NewPage";
import EditPage from "../pages/EditPage";
import ModuleWrapper from "../components/ModuleWrapper";
import AuthPage from "../pages/auth/AuthPage";
import PrivateRoute from "./PrivateRoute";

const AppRoutes = () => {
  return (
    <Routes>
      {/* Login */}
      <Route path="/" element={<AuthPage />} />
      <Route path="/login" element={<AuthPage />} />

      {/* Home protegido */}
      <Route
        path="/home"
        element={
          <PrivateRoute>
            <Home />
          </PrivateRoute>
        }
      />

      {/* Rotas dinâmicas de módulos protegidas */}
      <Route
        path="/:moduleName"
        element={
          <PrivateRoute>
            <ModuleWrapper>
              <ListPage />
            </ModuleWrapper>
          </PrivateRoute>
        }
      />
      <Route
        path="/:moduleName/novo"
        element={
          <PrivateRoute>
            <ModuleWrapper>
              <NewPage />
            </ModuleWrapper>
          </PrivateRoute>
        }
      />
      <Route
        path="/:moduleName/editar/:id"
        element={
          <PrivateRoute>
            <ModuleWrapper>
              <EditPage />
            </ModuleWrapper>
          </PrivateRoute>
        }
      />

      <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

export default AppRoutes;
