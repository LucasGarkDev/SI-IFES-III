#ifndef ARM_HPP
#define ARM_HPP

#include "../HardwareArchitecture.hpp"
#include <iostream>

class ARM : public HardwareArchitecture {
public:
    void executarInstrucao(const std::string& instrucao) override {
        std::cout << "[ARM] Executando: " << instrucao << std::endl;
    }
};

#endif
