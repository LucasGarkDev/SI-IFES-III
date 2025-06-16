import { PagamentoCredito } from "./PagamentoCredito";
import { PagamentoPIX } from "./PagamentoPIX";
import { PagamentoBoleto } from "./PagamentoBoleto";
window.finalizarCompra = function (forma) {
    const valor = 100;
    let pagamento;
    switch (forma) {
        case "credito":
            pagamento = new PagamentoCredito(valor);
            break;
        case "pix":
            pagamento = new PagamentoPIX(valor);
            break;
        case "boleto":
            pagamento = new PagamentoBoleto(valor);
            break;
        default:
            alert("Forma de pagamento inválida");
            return;
    }
    pagamento.processar();
};
window.finalizarSelecionado = function () {
    const select = document.getElementById("forma-pagamento");
    if (!select)
        return;
    const forma = select.value;
    window.finalizarCompra(forma);
};
// ✅ Função auxiliar para exibir mensagens no HTML e console
export function mostrarMensagemNaTela(texto) {
    const resumo = document.getElementById("resumo");
    if (resumo)
        resumo.innerHTML = `<p>${texto}</p>`;
    console.log(`[LOG] ${texto}`);
}
