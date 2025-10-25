// src/context/AppContext.jsx
import { createContext, useState, useEffect } from "react";
import { inicializarDados } from "../service/api.js";

export const AppContext = createContext();

export const AppProvider = ({ children }) => {
  const [loaded, setLoaded] = useState(false);
  const [userLoged, setUserLoged] = useState(false);

  useEffect(() => {
    (async () => {
      try {
        await inicializarDados();
      } catch (err) {
        window.addAlert(`❌ Falha ao sincronizar dados! ${err}`, "danger");
      } finally {
        setLoaded(true);
      }
    })();
  }, []);

  return (
    <AppContext.Provider value={{ loaded, userLoged, setUserLoged }}>
      {children}
    </AppContext.Provider>
  );
};
