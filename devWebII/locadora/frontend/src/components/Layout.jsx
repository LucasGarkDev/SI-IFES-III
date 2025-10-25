// src/components/Layout.jsx
import Header from "./Header.jsx";
import Aside from "./Aside.jsx";
import AppRoutes from "../routes/VideoLocadoraRoutes.jsx";
import { useContext } from "react";
import { AppContext } from "../components/AppContext.jsx";
import Loading from "./Loading.jsx";
import modules from "../js/config/modules.js";

const Layout = () => {
  const { loaded } = useContext(AppContext);

  const asideLinks = [
    { path: "/home", label: "Início" },
    ...modules.flatMap(({ name, label }) => [
      { path: `/${name}`, label },
      { path: `/${name}/novo`, label: `Novo ${label}` },
    ]),
  ];

  return (
    <>
      <Header />
      <div className="container-fluid">
        <div className="row">
          <div className="col-12 col-md-3 col-lg-2">
            <Aside links={asideLinks} />
          </div>
          <div className="col-12 col-md-9 col-lg-10">
            <AppRoutes />
          </div>
        </div>
      </div>
      {!loaded && <Loading />}
    </>
  );
};

export default Layout;
