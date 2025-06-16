"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoBoleto = void 0;
const Pagamento_1 = require("./Pagamento");
class PagamentoBoleto extends Pagamento_1.Pagamento {
    calcularDesconto() {
        return this.valorBase * 0.05;
    }
}
exports.PagamentoBoleto = PagamentoBoleto;
