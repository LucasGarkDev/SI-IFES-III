"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoPIX = void 0;
const Pagamento_1 = require("./Pagamento");
const app_1 = require("./app");
class PagamentoPIX extends Pagamento_1.Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.10;
        (0, app_1.mostrarMensagemNaTela)("Pagamento com PIX - desconto de 10% aplicado.");
        return desconto;
    }
}
exports.PagamentoPIX = PagamentoPIX;
