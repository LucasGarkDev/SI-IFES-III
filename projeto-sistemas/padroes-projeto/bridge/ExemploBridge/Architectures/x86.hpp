#ifndef X86_HPP
#define X86_HPP

#include "../HardwareArchitecture.hpp"
#include <iostream>

class x86 : public HardwareArchitecture {
public:
    void executarInstrucao(const std::string& instrucao) override {
        std::cout << "[x86] Executando: " << instrucao << std::endl;
    }
};

#endif
