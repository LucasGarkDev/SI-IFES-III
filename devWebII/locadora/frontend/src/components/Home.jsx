// src/pages/Home.jsx
import React from "react";
import AutoDismissAlert from "./AutoDismissAlert";
import ConfirmModal from "./ConfirmModal";

const Home = () => {
  return (
    <main className="container mt-4">
      <div className="text-center">
        <h1 className="mb-3">🎬 Bem-vindo à Vídeo Locadora!</h1>
        <AutoDismissAlert
          message="TIRA QUE O SEBASTIÃO VAI CAGAR!"
          type="success"
          duration={5000}
        />
        <ConfirmModal
          title="Confirmação"
          message="Deseja realmente excluir este item?"
          onConfirm={() => console.log("Ok clicado")}
          onCancel={() => console.log("Cancel clicado")}
        />

        <p className="lead">Explore nossa coleção de filmes e séries.</p>
      </div>
    </main>
  );
};

export default Home;
