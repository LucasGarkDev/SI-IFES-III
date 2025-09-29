import React from "react";
import "../../styles/forms.css";

function FormContainer({ title, children, onSubmit }) {
  return (
    <form className="form-container" onSubmit={onSubmit}>
      {title && <h3>{title}</h3>}
      <div className="form-fields">{children}</div>
    </form>
  );
}

export default FormContainer;
