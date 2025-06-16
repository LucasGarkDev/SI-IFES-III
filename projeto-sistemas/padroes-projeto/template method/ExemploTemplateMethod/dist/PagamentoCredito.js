"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PagamentoCredito = void 0;
const Pagamento_1 = require("./Pagamento");
class PagamentoCredito extends Pagamento_1.Pagamento {
    calcularDesconto() {
        return 0;
    }
}
exports.PagamentoCredito = PagamentoCredito;
