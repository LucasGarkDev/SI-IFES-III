import React from "react";
import './css/videoLocadora.css';
import Header from "./components/Header.jsx";
import AppRoutes from "./routes/VideoLocadoraRoutes.jsx";
import { BrowserRouter } from "react-router-dom";
import Aside from "./components/Aside.jsx";

const VideoLocadora = () => {
  return (
    <BrowserRouter>
      <Header />
      <Aside />
      <AppRoutes />
    </BrowserRouter>
  );
};

export default VideoLocadora;