// main.cpp
#include <iostream>
#include "Architectures/microcontrolador.hpp"
#include "Architectures/ARM.hpp"
#include "Architectures/x86.hpp"
#include "Softwares/EditorTexto.hpp"
#include "Softwares/NavegadorWeb.hpp"
#include "Softwares/controleEmbarcado.hpp"

int main() {
    HardwareArchitecture* arm = new ARM();
    HardwareArchitecture* x86arch = new x86();
    HardwareArchitecture* micro = new microcontrolador();

    Software* editorARM = new EditorTexto(arm);
    Software* navegadorX86 = new NavegadorWeb(x86arch);
    Software* contoleDePortaEletronica = new controleEmbarcado(micro);

    editorARM->rodar();
    std::cout << "-----------------------------" << std::endl;
    navegadorX86->rodar();
    std::cout << "-----------------------------" << std::endl;
    contoleDePortaEletronica->rodar();

    delete editorARM;
    delete navegadorX86;
    delete arm;
    delete x86arch;
    delete micro;

    return 0;
}
