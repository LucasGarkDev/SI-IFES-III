// Softwares/ControleEmbarcado.hpp
#ifndef CONTROLEEMBARCADO_HPP
#define CONTROLEEMBARCADO_HPP

#include "../Software.hpp"
#include <iostream>

class ControleEmbarcado : public Software {
public:
    ControleEmbarcado(HardwareArchitecture* arquitetura) : Software(arquitetura) {}

    void rodar() override {
        std::cout << "Iniciando Firmware..." << std::endl;
        arquitetura->executarInstrucao("Enviando Comandos I/O");
        arquitetura->executarInstrucao("Recebendo comandos I/O");
    }
};

#endif
