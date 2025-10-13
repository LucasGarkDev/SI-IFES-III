import React, { useEffect, useState } from "react";

const AutoDismissAlert = ({ message, type = "success", duration = 3000 }) => {
	const [visible, setVisible] = useState(true);

	useEffect(() => {
		const timer = setTimeout(() => setVisible(false), duration);
		return () => clearTimeout(timer);
	}, [duration]);

	if (!visible) return null;

	return (
		<div
			className={`auto-alert alert alert-${type} alert-dismissible fade show`}
			role="alert"
		>
			{message}
		</div>
	);
};

export default AutoDismissAlert;
