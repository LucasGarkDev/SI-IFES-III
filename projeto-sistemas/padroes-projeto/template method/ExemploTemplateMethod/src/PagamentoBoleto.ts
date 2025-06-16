import { Pagamento } from "./Pagamento";
import { mostrarMensagemNaTela } from "./app";

export class PagamentoBoleto extends Pagamento {
  protected calcularDesconto(): number {
    const desconto = this.valorBase * 0.05;
    mostrarMensagemNaTela("Pagamento com Boleto - desconto de 5% aplicado.");
    return desconto;
  }
}
