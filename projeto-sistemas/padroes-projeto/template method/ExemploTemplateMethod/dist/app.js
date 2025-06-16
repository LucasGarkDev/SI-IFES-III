import { PagamentoCredito } from "./PagamentoCredito.js";
import { PagamentoPIX } from "./PagamentoPIX.js";
import { PagamentoBoleto } from "./PagamentoBoleto.js";
window.finalizarCompra = function (forma) {
    const valor = 100;
    let pagamento;
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
window.finalizarSelecionado = function () {
    const select = document.getElementById("forma-pagamento");
    if (!select)
        return;
    const forma = select.value;
    window.finalizarCompra(forma);
};
