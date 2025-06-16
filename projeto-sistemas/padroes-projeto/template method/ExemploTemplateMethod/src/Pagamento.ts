export abstract class Pagamento {
  constructor(protected valorBase: number) {}

  public processar(): void {
    const desconto = this.calcularDesconto();
    const total = this.valorBase - desconto;
    this.exibirResumo(total, desconto);
  }

  protected abstract calcularDesconto(): number;

  protected exibirResumo(total: number, desconto: number): void {
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

