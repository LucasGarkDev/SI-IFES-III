// Architectures/ARM.cpp
#ifndef MICRO_HPP
#define MICRO_HPP

#include "../HardwareArchitecture.hpp"
#include <iostream>

class microcontrolador : public HardwareArchitecture {
public:
    void executarInstrucao(const std::string& instrucao) override {
        std::cout << "[MICRO] Executando: " << instrucao << std::endl;
    }
};

#endif
