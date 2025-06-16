import { Pagamento } from "./Pagamento";
import { mostrarMensagemNaTela } from "./util";

export class PagamentoCredito extends Pagamento {
  protected calcularDesconto(): number {
    const desconto = this.valorBase * 0.02;
    mostrarMensagemNaTela("Pagamento com Cartão de Crédito - desconto de 2% aplicado.");
    return desconto;
  }
}
