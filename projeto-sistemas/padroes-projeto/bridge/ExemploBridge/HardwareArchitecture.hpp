// HardwareArchitecture.hpp
#ifndef HARDWAREARCHITECTURE_HPP
#define HARDWAREARCHITECTURE_HPP

#include <string>

class HardwareArchitecture {
public:
    virtual void executarInstrucao(const std::string& instrucao) = 0;
    virtual ~HardwareArchitecture() = default;
};

#endif