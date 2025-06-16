import { Pagamento } from "./Pagamento";
import { mostrarMensagemNaTela } from "./app";

export class PagamentoCredito extends Pagamento {
  protected calcularDesconto(): number {
    const desconto = this.valorBase * 0.03;
    mostrarMensagemNaTela("Pagamento com Cartão - desconto de 3% aplicado.");
    return desconto;
  }
}
