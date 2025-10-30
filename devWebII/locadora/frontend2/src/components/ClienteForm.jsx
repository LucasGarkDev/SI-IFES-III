import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";
import "../styles/ClienteForm.css"; // novo estilo só para o botão

function ClienteForm({ onAdd }) {
  const [nome, setNome] = useState("");
  const [dtNascimento, setDtNascimento] = useState("");
  const [sexo, setSexo] = useState("");
  const [cpf, setCpf] = useState("");
  const [endereco, setEndereco] = useState("");
  const [telefone, setTelefone] = useState("");
  const [dependentes, setDependentes] = useState([]);

  const handleAddDependente = () => {
    setDependentes([...dependentes, { nome: "", dtNascimento: "", sexo: "" }]);
  };

  const handleChangeDependente = (index, field, value) => {
    const novos = [...dependentes];
    novos[index][field] = value;
    setDependentes(novos);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const socio = {
      nome,
      dtNascimento,
      sexo,
      cpf,
      endereco,
      telefone,
      dependentes: dependentes.filter(
        (d) => d.nome && d.dtNascimento && d.sexo
      ),
    };
    onAdd(socio);
    setNome("");
    setDtNascimento("");
    setSexo("");
    setCpf("");
    setEndereco("");
    setTelefone("");
    setDependentes([]);
  };

  return (
    <FormContainer title="Cadastrar Sócio" onSubmit={handleSubmit}>
      <InputField label="Nome" value={nome} onChange={(e) => setNome(e.target.value)} />
      <InputField label="Data de Nascimento" type="date" value={dtNascimento} onChange={(e) => setDtNascimento(e.target.value)} />
      <InputField label="Sexo" value={sexo} onChange={(e) => setSexo(e.target.value)} />
      <InputField label="CPF" value={cpf} onChange={(e) => setCpf(e.target.value)} />
      <InputField label="Endereço" value={endereco} onChange={(e) => setEndereco(e.target.value)} />
      <InputField label="Telefone" value={telefone} onChange={(e) => setTelefone(e.target.value)} />

      <div className="dependentes-box">
        <h4>Dependentes (opcional)</h4>
        {dependentes.map((dep, idx) => (
          <div key={idx} className="dependente-item">
            <InputField
              label="Nome"
              value={dep.nome}
              onChange={(e) => handleChangeDependente(idx, "nome", e.target.value)}
            />
            <InputField
              label="Nascimento"
              type="date"
              value={dep.dtNascimento}
              onChange={(e) =>
                handleChangeDependente(idx, "dtNascimento", e.target.value)
              }
            />
            <InputField
              label="Sexo"
              value={dep.sexo}
              onChange={(e) => handleChangeDependente(idx, "sexo", e.target.value)}
            />
          </div>
        ))}

        {/* botão retrô estilizado */}
        <button type="button" className="btn-add-dependente" onClick={handleAddDependente}>
          + Adicionar Dependente
        </button>
      </div>

      <SubmitButton label="Cadastrar Sócio" />
    </FormContainer>
  );
}

export default ClienteForm;
