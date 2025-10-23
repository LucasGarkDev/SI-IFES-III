# 📌 Endpoints disponíveis (até agora)

---

## 🎭 Atores (`/api/atores`)

- **GET** `/api/atores` → lista paginada de atores (filtros: `nome`, `ativo`).
- **GET** `/api/atores/{id}` → busca um ator por ID.
- **POST** `/api/atores` → cria novo ator.
- **PUT** `/api/atores/{id}` → atualiza ator existente.
- **DELETE** `/api/atores/{id}` → exclui ator.

---

## 🎬 Diretores (`/api/diretores`)

- **GET** `/api/diretores` → lista paginada de diretores (filtros: `nome`, `ativo`).
- **GET** `/api/diretores/{id}` → busca um diretor por ID.
- **POST** `/api/diretores` → cria novo diretor.
- **PUT** `/api/diretores/{id}` → atualiza diretor existente.
- **DELETE** `/api/diretores/{id}` → exclui diretor.

---

## 🏷️ Classes (`/api/classes`)

- **GET** `/api/classes` → lista paginada de classes (filtros: `nome`, `ativo`).
- **GET** `/api/classes/{id}` → busca uma classe por ID.
- **POST** `/api/classes` → cria nova classe (`nome`, `precoDiariaCentavos`, `dataDevolucao`).
- **PUT** `/api/classes/{id}` → atualiza classe existente.
- **DELETE** `/api/classes/{id}` → exclui classe.

---

## 💽 Itens (`/api/itens`)

- **GET** `/api/itens` → lista paginada de itens cadastrados (filtros: `tipoItem`, `tituloId`).
- **GET** `/api/itens/{id}` → busca um item específico por ID.
- **POST** `/api/itens` → cria novo item com os dados:
  - `numSerie`
  - `dtAquisicao`
  - `tipoItem` (*FITA*, *DVD*, *BLURAY*)
  - `tituloId` (referência a um título existente)
- **PUT** `/api/itens/{id}` → atualiza dados do item.
- **DELETE** `/api/itens/{id}` → exclui item (somente se não houver locações associadas).

---

## 🎞️ Títulos (`/api/titulos`)

- **GET** `/api/titulos` → lista paginada de títulos (filtros: `nome`, `categoria`, `ano`).
- **GET** `/api/titulos/{id}` → busca um título completo por ID.
- **POST** `/api/titulos` → cria novo título com os dados:
  - `nome`
  - `ano`
  - `categoria`
  - `sinopse`
  - `classeId`
  - `diretorId`
  - `atoresIds` (lista de IDs de atores)
- **PUT** `/api/titulos/{id}` → atualiza título existente.
- **DELETE** `/api/titulos/{id}` → exclui título (bloqueia exclusão se houver itens vinculados).

---

## 👥 Clientes (Sócios e Dependentes) (`/api/clientes`)

- **GET** `/api/clientes` → lista paginada de clientes (filtros: `nome`, `ativo`, `tipo`).
  - Retorna tanto sócios quanto dependentes.
  - Campos principais: `id`, `numInscricao`, `nome`, `sexo`, `dtNascimento`, `estaAtivo`, `tipoCliente`.
- **POST** `/api/clientes/socio` → cria novo sócio (e, opcionalmente, dependentes).
  - Campos obrigatórios:
    - `nome`, `dtNascimento`, `sexo`, `cpf`, `endereco`, `telefone`
  - Campo opcional:
    - `dependentes`: lista de até **3** objetos com `nome`, `dtNascimento`, `sexo`.
- **DELETE** `/api/clientes/{id}` → exclui cliente (se for sócio, exclui dependentes em cascata).
- *(em desenvolvimento)* **PUT** `/api/clientes/ativar/{id}` → reativa cliente inativo.
- *(em desenvolvimento)* **PUT** `/api/clientes/desativar/{id}` → desativa cliente ativo.

---

## ⚙️ Regras Gerais de Validação

- Todos os endpoints de **POST** e **PUT** validam campos obrigatórios via `@Valid` (DTO).  
- Mensagens de erro retornam formato padronizado JSON:
  ```json
  {
    "mensagem": "Erro de validação",
    "timestamp": "2025-10-09T13:30:00Z",
    "detalhes": "Campo 'nome' é obrigatório."
  }
