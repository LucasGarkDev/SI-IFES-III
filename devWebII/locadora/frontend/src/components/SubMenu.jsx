import React from "react";
import { Link, useLocation } from "react-router-dom";

const SubMenu = ({ links = [] }) => {
	const location = useLocation();

	return (
		<nav className="submenu mb-3">
			<ul className="submenu-list">
				{links.map((link, index) => {
					const isActive = location.pathname === link.path;
					return (
						<li key={index} className={`submenu-item ${isActive ? "active-link" : ""}`}>
							<Link to={link.path}>{link.label}</Link>
						</li>
					);
				})}
			</ul>
		</nav>
	);
};

export default SubMenu;
