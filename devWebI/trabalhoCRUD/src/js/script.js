function inserirContato() {
  const nome = document.getElementById("nome").value.trim();
  const telefone = document.getElementById("telefone").value.trim();
  const email = document.getElementById("email").value.trim();

  if (!nome || !telefone || !email) {
    alert("Preencha todos os campos!");
    return;
  }

  const tabela = document.getElementById("tabelaContatos");
  const novaLinha = tabela.insertRow();

  novaLinha.innerHTML = `
    <td>${nome}</td>
    <td>${telefone}</td>
    <td>${email}</td>
    <td class="acoes">
      <button class="editar" onclick="editarContato(this)">Editar</button>
      <button class="excluir" onclick="excluirContato(this)">Excluir</button>
    </td>
  `;

  // Limpa os campos após inserir
  document.getElementById("nome").value = "";
  document.getElementById("telefone").value = "";
  document.getElementById("email").value = "";
}

function excluirContato(botao) {
  if (confirm("Deseja realmente excluir este contato?")) {
    const linha = botao.parentNode.parentNode;
    linha.remove();
  }
}

function editarContato(botao) {
  const linha = botao.parentNode.parentNode;
  const colunas = linha.querySelectorAll("td");

  const nomeAtual = colunas[0].textContent;
  const telefoneAtual = colunas[1].textContent;
  const emailAtual = colunas[2].textContent;

  colunas[0].innerHTML = `<input type="text" value="${nomeAtual}">`;
  colunas[1].innerHTML = `<input type="tel" value="${telefoneAtual}">`;
  colunas[2].innerHTML = `<input type="email" value="${emailAtual}">`;
  colunas[3].innerHTML = `
    <button class="salvar" onclick="salvarEdicao(this)">Salvar</button>
    <button class="cancelar" onclick="cancelarEdicao(this, '${nomeAtual}', '${telefoneAtual}', '${emailAtual}')">Cancelar</button>
  `;
}

function salvarEdicao(botao) {
  const linha = botao.parentNode.parentNode;
  const inputs = linha.querySelectorAll("input");

  const novoNome = inputs[0].value.trim();
  const novoTelefone = inputs[1].value.trim();
  const novoEmail = inputs[2].value.trim();

  if (!novoNome || !novoTelefone || !novoEmail) {
    alert("Todos os campos devem ser preenchidos!");
    return;
  }

  linha.innerHTML = `
    <td>${novoNome}</td>
    <td>${novoTelefone}</td>
    <td>${novoEmail}</td>
    <td class="acoes">
      <button class="editar" onclick="editarContato(this)">Editar</button>
      <button class="excluir" onclick="excluirContato(this)">Excluir</button>
    </td>
  `;
}

function cancelarEdicao(botao, nome, telefone, email) {
  const linha = botao.parentNode.parentNode;

  linha.innerHTML = `
    <td>${nome}</td>
    <td>${telefone}</td>
    <td>${email}</td>
    <td class="acoes">
      <button class="editar" onclick="editarContato(this)">Editar</button>
      <button class="excluir" onclick="excluirContato(this)">Excluir</button>
    </td>
  `;
}
