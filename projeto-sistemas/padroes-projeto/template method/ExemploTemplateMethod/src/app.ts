import { PagamentoCredito } from "./PagamentoCredito";
import { PagamentoPIX } from "./PagamentoPIX";
import { PagamentoBoleto } from "./PagamentoBoleto";
import { Pagamento } from "./Pagamento";

declare global {
  interface Window {
    finalizarCompra: (forma: string) => void;
    finalizarSelecionado: () => void;
  }
}

window.finalizarCompra = function (forma: string): void {
  const valor = 100;
  let pagamento: Pagamento;

  switch (forma) {
    case "credito":
      pagamento = new PagamentoCredito(valor);
      break;
    case "pix":
      pagamento = new PagamentoPIX(valor);
      break;
    case "boleto":
      pagamento = new PagamentoBoleto(valor);
      break;
    default:
      alert("Forma de pagamento inválida");
      return;
  }

  pagamento.processar();
};

window.finalizarSelecionado = function (): void {
  const select = document.getElementById("forma-pagamento") as HTMLSelectElement;
  const forma = select?.value;

  if (!forma) {
    alert("Selecione uma forma de pagamento.");
    return;
  }

  console.log(`[EVENTO] Pagamento iniciado com forma: ${forma}`);
  window.finalizarCompra(forma);
};

export function mostrarMensagemNaTela(texto: string): void {
  const resumo = document.getElementById("resumo");
  if (resumo) resumo.innerHTML = `<p>${texto}</p>`;
  console.log(`[LOG] ${texto}`);
}
