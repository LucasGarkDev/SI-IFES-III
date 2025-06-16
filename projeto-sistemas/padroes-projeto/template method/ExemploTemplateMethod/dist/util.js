"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.mostrarMensagemNaTela = mostrarMensagemNaTela;
function mostrarMensagemNaTela(texto) {
    const resumo = document.getElementById("resumo");
    if (resumo) {
        const p = document.createElement("p");
        p.innerText = texto;
        resumo.appendChild(p);
    }
    console.log(`[INFO] ${texto}`);
}
