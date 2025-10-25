// src/VideoLocadora.jsx
import { BrowserRouter } from "react-router-dom";
import Layout from "./components/Layout.jsx";
import AlertManager from "./components/AlertManager.jsx";
import { AppProvider } from "./components/AppContext.jsx";
import "./css/VideoLocadora.css";


const VideoLocadora = () => (
  <AppProvider>
    <BrowserRouter>
      <Layout />
      <AlertManager />
    </BrowserRouter>
  </AppProvider>
);

export default VideoLocadora;
