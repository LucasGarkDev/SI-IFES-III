import { Pagamento } from "./Pagamento";

export class PagamentoCredito extends Pagamento {
  protected calcularDesconto(): number {
    return 0;
  }
}
