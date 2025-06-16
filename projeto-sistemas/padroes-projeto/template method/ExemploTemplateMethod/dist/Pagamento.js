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
        this.exibirResumo(total, desconto);
    }
    exibirResumo(total, desconto) {
        const div = document.getElementById("resumo");
        if (div) {
            div.innerHTML = `
        <p>Desconto aplicado: <strong>R$ ${desconto.toFixed(2)}</strong></p>
        <p>Valor final: <strong>R$ ${total.toFixed(2)}</strong></p>
      `;
        }
        console.log(`[LOG] Desconto de R$ ${desconto.toFixed(2)} aplicado. Total: R$ ${total.toFixed(2)}`);
    }
}
exports.Pagamento = Pagamento;
