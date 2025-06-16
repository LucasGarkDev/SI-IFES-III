"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const PagamentoCredito_1 = require("./PagamentoCredito");
const PagamentoPIX_1 = require("./PagamentoPIX");
const PagamentoBoleto_1 = require("./PagamentoBoleto");
window.finalizarCompra = function (forma) {
    const valor = 100;
    let pagamento;
    switch (forma) {
        case "credito":
            pagamento = new PagamentoCredito_1.PagamentoCredito(valor);
            break;
        case "pix":
            pagamento = new PagamentoPIX_1.PagamentoPIX(valor);
            break;
        case "boleto":
            pagamento = new PagamentoBoleto_1.PagamentoBoleto(valor);
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
