// src/pages/Home.jsx
import React from "react";
import ConfirmModal from "./ConfirmModal";
import AutoDismissAlert from "./subcomponents/AutoDismissAlert";

const Home = () => {
  return (
    <main className="container mt-4">
      <div className="text-center">
        <h1 className="mb-3">🎬 Bem-vindo à Vídeo Locadora!</h1>
        <AutoDismissAlert
          message="SISTEMA INICIALIZADO!"
          type="success"
          duration={5000}
        />
        <img className="img-fluid w-50" src="./src/assets/logo/video-locadora-retro-logo.png" alt="Bem-vindo à Vídeo Locadora!" />

        <p className="lead">Explore nossa coleção de filmes e séries.</p>
      </div>
    </main>
  );
};

export default Home;
