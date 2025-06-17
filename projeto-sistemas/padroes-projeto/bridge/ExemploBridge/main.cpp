#include <iostream>
#include "Architectures/ARM.hpp"
#include "Architectures/x86.hpp"
#include "Softwares/EditorTexto.hpp"
#include "Softwares/NavegadorWeb.hpp"

int main() {
    HardwareArchitecture* arm = new ARM();
    HardwareArchitecture* x86arch = new x86();

    Software* editorARM = new EditorTexto(arm);
    Software* navegadorX86 = new NavegadorWeb(x86arch);

    editorARM->rodar();
    std::cout << "-----------------------------" << std::endl;
    navegadorX86->rodar();

    delete editorARM;
    delete navegadorX86;
    delete arm;
    delete x86arch;

    return 0;
}
