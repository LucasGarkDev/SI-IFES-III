"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoCredito = void 0;
const Pagamento_1 = require("./Pagamento");
const util_1 = require("./util");
class PagamentoCredito extends Pagamento_1.Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.02;
        (0, util_1.mostrarMensagemNaTela)("Pagamento com Cartão de Crédito - desconto de 2% aplicado.");
        return desconto;
    }
}
exports.PagamentoCredito = PagamentoCredito;
