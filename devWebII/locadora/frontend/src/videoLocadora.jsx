// src/VideoLocadora.jsx
import React, { useState, useEffect } from "react";
import "./css/videoLocadora.css";
import Header from "./components/Header.jsx";
import AppRoutes from "./routes/VideoLocadoraRoutes.jsx";
import { BrowserRouter } from "react-router-dom";
import Aside from "./components/Aside.jsx";
import modules from "./js/config/modules.js";
import { initData } from "./service/api.js";

const VideoLocadora = () => {
  const [loaded, setLoaded] = useState(false);

  useEffect(() => {
    (async () => {
      await initData();
      setLoaded(true);
    })();
  }, []);

  if (!loaded) return <p>Carregando Banco de dados...</p>;

  const asideLinks = [
    { path: "/", label: "Início" },
    ...modules.flatMap(({ name, label }) => [
      { path: `/${name}`, label },
      { path: `/${name}/novo`, label: `Novo ${label}` },
    ]),
  ];

  return (
    <BrowserRouter>
      <Header />
      <div className="container-fluid">
        <div className="row">
          {/* Coluna do Aside */}
          <div className="col-12 col-md-3 col-lg-2">
            <Aside links={asideLinks} />
          </div>

          {/* Coluna do conteúdo principal */}
          <div className="col-12 col-md-9 col-lg-10">
            <AppRoutes />
          </div>
        </div>
      </div>
    </BrowserRouter>
  );
};

export default VideoLocadora;