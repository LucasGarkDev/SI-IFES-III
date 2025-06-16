import { Pagamento } from "./Pagamento";
import { mostrarMensagemNaTela } from "./util";
export class PagamentoBoleto extends Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.05;
        mostrarMensagemNaTela("Pagamento com Boleto - desconto de 5% aplicado.");
        return desconto;
    }
}
