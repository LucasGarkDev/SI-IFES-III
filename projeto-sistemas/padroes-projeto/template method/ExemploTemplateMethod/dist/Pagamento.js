"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Pagamento = void 0;
class Pagamento {
    constructor(valorBase) {
        this.valorBase = valorBase;
    }
    processar() {
        const desconto = this.calcularDesconto();
        const total = this.valorBase - desconto;
        this.exibirResumo(total);
    }
    exibirResumo(total) {
        const div = document.getElementById("resumo");
        if (div) {
            div.innerHTML = `Valor com desconto: <strong>R$ ${total.toFixed(2)}</strong>`;
        }
    }
}
exports.Pagamento = Pagamento;
