"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoPIX = void 0;
const Pagamento_1 = require("./Pagamento");
class PagamentoPIX extends Pagamento_1.Pagamento {
    calcularDesconto() {
        return this.valorBase * 0.10;
    }
}
exports.PagamentoPIX = PagamentoPIX;
