"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.mostrarMensagemNaTela = mostrarMensagemNaTela;
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
    const forma = select === null || select === void 0 ? void 0 : select.value;
    if (!forma) {
        alert("Selecione uma forma de pagamento.");
        return;
    }
    console.log(`[EVENTO] Pagamento iniciado com forma: ${forma}`);
    window.finalizarCompra(forma);
};
function mostrarMensagemNaTela(texto) {
    const resumo = document.getElementById("resumo");
    if (resumo)
        resumo.innerHTML = `<p>${texto}</p>`;
    console.log(`[LOG] ${texto}`);
}
