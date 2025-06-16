import { Pagamento } from "./Pagamento";

export class PagamentoBoleto extends Pagamento {
  protected calcularDesconto(): number {
    return this.valorBase * 0.05;
  }
}
