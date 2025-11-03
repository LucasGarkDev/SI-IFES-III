// src/components/Aside.jsx
import React from "react";
import { Link, useLocation } from "react-router-dom";

const Aside = ({ links = [] }) => {
  const location = useLocation();

  return (
    <aside className="bg-light border rounded p-3">
      <h4 className="mb-3">Menu</h4>
      <nav>
        <ul className="list-group">
          {links.map((link, index) => {
            const isActive = location.pathname === link.path;

            return (
              <li
                key={index}
                className={`list-group-item ${isActive ? "active-link" : ""}`}
              >
                <Link to={link.path}>{link.label}</Link>
              </li>
            );
          })}
        </ul>
      </nav>
    </aside>
  );
};

export default Aside;