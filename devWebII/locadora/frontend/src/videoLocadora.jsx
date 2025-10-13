import React, { useState, useEffect } from "react";
import "./css/VideoLocadora.css";
import Header from "./components/Header.jsx";
import AppRoutes from "./routes/VideoLocadoraRoutes.jsx";
import { BrowserRouter } from "react-router-dom";
import Aside from "./components/Aside.jsx";
import modules from "./js/config/modules.js";
import Loading from "./components/Loading.jsx";
import AlertManager from "./components/AlertManager.jsx";
import { inicializarDados } from "./service/api.js";

const VideoLocadora = () => {
  const [loaded, setLoaded] = useState(false);

  useEffect(() => {
    (async () => {
      try {
      await inicializarDados();
    } catch (err) {
      window.addAlert(`❌ Falha ao sincronizar dados! ${err}`, "danger");
    } finally {
      setLoaded(true); // sempre carregar o app
    }
    })();
  }, []);

  const asideLinks = [
    { path: "/home", label: "Início" },
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

      {/* Overlay de Loading */}
      {!loaded && <Loading />}

      {/* ✅ AlertManager global — sempre visível e fora da grid */}
      <AlertManager />
    </BrowserRouter>
  );
};

export default VideoLocadora;
