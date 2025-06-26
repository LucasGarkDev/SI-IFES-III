// Architectures/Microcontrolador.cpp
#ifndef MICRO_HPP
#define MICRO_HPP

#include "../HardwareArchitecture.hpp"
#include <iostream>

class Microcontrolador : public HardwareArchitecture {
public:
    void executarInstrucao(const std::string& instrucao) override {
        std::cout << "[MICRO] Executando: " << instrucao << std::endl;
    }
};

#endif
