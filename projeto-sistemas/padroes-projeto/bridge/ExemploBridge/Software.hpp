// Software.hpp
#ifndef SOFTWARE_HPP
#define SOFTWARE_HPP

#include "HardwareArchitecture.hpp"

class Software {
protected:
    HardwareArchitecture* arquitetura;

public:
    Software(HardwareArchitecture* arquitetura) : arquitetura(arquitetura) {}
    virtual void rodar() = 0;
    virtual ~Software() = default;
};

#endif
