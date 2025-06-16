import { Pagamento } from "./Pagamento";
import { mostrarMensagemNaTela } from "./util";
export class PagamentoPIX extends Pagamento {
    calcularDesconto() {
        const desconto = this.valorBase * 0.10;
        mostrarMensagemNaTela("Pagamento com PIX - desconto de 10% aplicado.");
        return desconto;
    }
}
