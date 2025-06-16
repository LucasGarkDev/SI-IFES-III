"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoCredito = void 0;
const Pagamento_1 = require("./Pagamento");
const app_1 = require("./app");
class PagamentoCredito extends Pagamento_1.Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.03;
        (0, app_1.mostrarMensagemNaTela)("Pagamento com Cartão - desconto de 3% aplicado.");
        return desconto;
    }
}
exports.PagamentoCredito = PagamentoCredito;
