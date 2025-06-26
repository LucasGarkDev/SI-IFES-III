// main.cpp
#include <iostream>
#include "Architectures/Microcontrolador.hpp"
#include "Architectures/ARM.hpp"
#include "Architectures/x86.hpp"
#include "Softwares/EditorTexto.hpp"
#include "Softwares/NavegadorWeb.hpp"
#include "Softwares/ControleEmbarcado.hpp"

int main() {
    HardwareArchitecture* arm = new ARM();
    HardwareArchitecture* x86arch = new x86();
    HardwareArchitecture* micro = new Microcontrolador();

    // Software* editorARM = new EditorTexto(arm);
    Software* navegador = new NavegadorWeb(x86arch);
    // Software* contoleDePortaEletronica = new ControleEmbarcado(micro);

    // editorARM->rodar();
    // std::cout << "-----------------------------" << std::endl;
    navegador->rodar();
    // std::cout << "-----------------------------" << std::endl;
    // contoleDePortaEletronica->rodar();

    // delete editorARM;
    delete navegador;
    // delete contoleDePortaEletronica;
    delete arm;
    delete x86arch;
    delete micro;

    return 0;
}
