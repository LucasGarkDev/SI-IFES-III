// src/components/Aside.jsx
import React from "react";
import { Link } from "react-router-dom";

const Aside = ({ links = [] }) => {
  return (
    <aside className="bg-light border rounded p-3">
      <h4 className="mb-3">Menu</h4>
      <nav>
        <ul className="list-group">
          {links.map((link, index) => (
            <li key={index} className="list-group-item">
              <Link to={link.path} className="text-decoration-none">
                {link.label}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
    </aside>
  );
};

export default Aside;