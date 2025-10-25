import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

// Equivalente a __dirname em ES Modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const envPath = path.resolve(__dirname, "../../.env"); // Ajuste o caminho se necessário

const defaultEnvContent = `
VITE_BACKEND_PORT=8085
VITE_BACKEND_DOMAIN=localhost
VITE_PRODUCTION_URL=https://my-json-server.typicode.com/typicode/demo/
`.trim();

if (fs.existsSync(envPath)) {
  console.log(".env já existe. Nenhuma ação necessária.");
} else {
  try {
    fs.writeFileSync(envPath, defaultEnvContent + "\n", { encoding: "utf8" });
    console.log(".env criado com sucesso com as variáveis padrão.");
  } catch (err) {
    console.error("Erro ao criar o arquivo .env:", err);
    process.exit(1);
  }
}