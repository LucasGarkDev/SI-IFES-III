// Softwares/EditorTexto.hpp
#ifndef EDITORTEXTO_HPP
#define EDITORTEXTO_HPP

#include "../Software.hpp"
#include <iostream>

class EditorTexto : public Software {
public:
    EditorTexto(HardwareArchitecture* arquitetura) : Software(arquitetura) {}

    void rodar() override {
        std::cout << "Abrindo Editor de Texto..." << std::endl;
        arquitetura->executarInstrucao("abrir_editor");
        arquitetura->executarInstrucao("escrever_texto");
    }
};

#endif
