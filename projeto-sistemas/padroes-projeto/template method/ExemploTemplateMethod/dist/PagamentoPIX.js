"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoPIX = void 0;
const Pagamento_1 = require("./Pagamento");
const util_1 = require("./util");
class PagamentoPIX extends Pagamento_1.Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.10;
        (0, util_1.mostrarMensagemNaTela)("Pagamento com PIX - desconto de 10% aplicado.");
        return desconto;
    }
}
exports.PagamentoPIX = PagamentoPIX;
