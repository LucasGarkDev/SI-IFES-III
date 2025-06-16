import { Pagamento } from "./Pagamento";

export class PagamentoPIX extends Pagamento {
  protected calcularDesconto(): number {
    return this.valorBase * 0.10;
  }
}
