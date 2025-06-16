import { PagamentoCredito } from "./PagamentoCredito";
import { PagamentoPIX } from "./PagamentoPIX";
import { PagamentoBoleto } from "./PagamentoBoleto";
import { Pagamento } from "./Pagamento";

declare global {
  interface Window {
    finalizarCompra: (forma: string) => void;
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
