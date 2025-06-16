"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoBoleto = void 0;
const Pagamento_1 = require("./Pagamento");
const app_1 = require("./app");
class PagamentoBoleto extends Pagamento_1.Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.05;
        (0, app_1.mostrarMensagemNaTela)("Pagamento com Boleto - desconto de 5% aplicado.");
        return desconto;
    }
}
exports.PagamentoBoleto = PagamentoBoleto;
