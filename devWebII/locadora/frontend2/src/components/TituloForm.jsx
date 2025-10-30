import React, { useState } from "react";
import FormContainer from "./ui/FormContainer";
import InputField from "./ui/InputField";
import SubmitButton from "./ui/SubmitButton";
import SelectModal from "./ui/SelectModal"; // popup retrô de seleção
import { getClasses } from "../services/classeService";
import { getDiretores } from "../services/diretorService";
import { getAtores } from "../services/atorService";

function TituloForm({ onAdd }) {
  const [nome, setNome] = useState("");
  const [ano, setAno] = useState("");
  const [sinopse, setSinopse] = useState("");
  const [categoria, setCategoria] = useState("");

  // seletores relacionados
  const [classeSelecionada, setClasseSelecionada] = useState(null);
  const [diretorSelecionado, setDiretorSelecionado] = useState(null);
  const [atoresSelecionados, setAtoresSelecionados] = useState([]);

  // controle dos modais
  const [modalClasse, setModalClasse] = useState(false);
  const [modalDiretor, setModalDiretor] = useState(false);
  const [modalAtores, setModalAtores] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();

    if (!nome || !ano || !categoria || !classeSelecionada || !diretorSelecionado || atoresSelecionados.length === 0) {
      alert("Preencha todos os campos e selecione classe, diretor e atores!");
      return;
    }

    onAdd({
      nome,
      ano: parseInt(ano, 10),
      sinopse,
      categoria,
      classeId: classeSelecionada.id,
      diretorId: diretorSelecionado.id,
      atoresIds: atoresSelecionados.map((a) => a.id),
    });

    // limpa os campos
    setNome("");
    setAno("");
    setSinopse("");
    setCategoria("");
    setClasseSelecionada(null);
    setDiretorSelecionado(null);
    setAtoresSelecionados([]);
  };

  const removerAtor = (id) => {
    setAtoresSelecionados((prev) => prev.filter((a) => a.id !== id));
  };

  return (
    <FormContainer title="Cadastrar Título" onSubmit={handleSubmit}>
      <InputField label="Nome" value={nome} onChange={(e) => setNome(e.target.value)} />
      <InputField label="Ano" type="number" value={ano} onChange={(e) => setAno(e.target.value)} />
      <InputField label="Categoria" value={categoria} onChange={(e) => setCategoria(e.target.value)} />
      <InputField label="Sinopse" value={sinopse} onChange={(e) => setSinopse(e.target.value)} />

      {/* Selecionar Classe */}
      <div className="input-field">
        <label>Classe:</label>
        <input
          type="text"
          readOnly
          value={classeSelecionada ? classeSelecionada.nome : ""}
          placeholder="Nenhuma classe selecionada"
          onClick={() => setModalClasse(true)}
        />
        <button type="button" className="btn-select" onClick={() => setModalClasse(true)}>
          Selecionar
        </button>
      </div>

      {/* Selecionar Diretor */}
      <div className="input-field">
        <label>Diretor:</label>
        <input
          type="text"
          readOnly
          value={diretorSelecionado ? diretorSelecionado.nome : ""}
          placeholder="Nenhum diretor selecionado"
          onClick={() => setModalDiretor(true)}
        />
        <button type="button" className="btn-select" onClick={() => setModalDiretor(true)}>
          Selecionar
        </button>
      </div>

      {/* Selecionar Atores */}
      <div className="input-field">
        <label>Atores:</label>
        <input
          type="text"
          readOnly
          value={
            atoresSelecionados.length > 0
              ? atoresSelecionados.map((a) => a.nome).join(", ")
              : ""
          }
          placeholder="Nenhum ator selecionado"
          onClick={() => setModalAtores(true)}
        />
        <button type="button" className="btn-select" onClick={() => setModalAtores(true)}>
          Selecionar
        </button>
      </div>

      {/* Lista de atores selecionados */}
      {atoresSelecionados.length > 0 && (
        <ul
          style={{
            listStyle: "none",
            padding: 0,
            marginTop: "6px",
            fontFamily: "Courier New, monospace",
          }}
        >
          {atoresSelecionados.map((a) => (
            <li key={a.id}>
              {a.nome}{" "}
              <button
                type="button"
                className="btn-select"
                style={{ padding: "2px 4px", marginLeft: "4px" }}
                onClick={() => removerAtor(a.id)}
              >
                Remover
              </button>
            </li>
          ))}
        </ul>
      )}

      <SubmitButton label="Adicionar" />

      {/* Modais de seleção */}
      <SelectModal
        isOpen={modalClasse}
        title="Selecionar Classe"
        fetchItems={getClasses}
        onSelect={(c) => setClasseSelecionada(c)}
        onClose={() => setModalClasse(false)}
      />
      <SelectModal
        isOpen={modalDiretor}
        title="Selecionar Diretor"
        fetchItems={getDiretores}
        onSelect={(d) => setDiretorSelecionado(d)}
        onClose={() => setModalDiretor(false)}
      />
      <SelectModal
        isOpen={modalAtores}
        title="Selecionar Atores"
        fetchItems={getAtores}
        onSelect={(ator) => {
          setAtoresSelecionados((prev) =>
            prev.some((a) => a.id === ator.id) ? prev : [...prev, ator]
          );
        }}
        onClose={() => setModalAtores(false)}
      />
    </FormContainer>
  );
}

export default TituloForm;
