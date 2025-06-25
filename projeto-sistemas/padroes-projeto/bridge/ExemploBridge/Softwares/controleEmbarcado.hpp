// Softwares/EditorTexto.hpp
#ifndef CONTROLEEMBARCADO_HPP
#define CONTROLEEMBARCADO_HPP

#include "../Software.hpp"
#include <iostream>

class controleEmbarcado : public Software {
public:
    controleEmbarcado(HardwareArchitecture* arquitetura) : Software(arquitetura) {}

    void rodar() override {
        std::cout << "Iniciando Firmware..." << std::endl;
        arquitetura->executarInstrucao("Enviando Comandos I/O");
        arquitetura->executarInstrucao("Recebendo comandos I/O");
    }
};

#endif
