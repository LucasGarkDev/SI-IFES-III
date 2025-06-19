// Softwares/NavegadorWeb.hpp
#ifndef NAVEGADORWEB_HPP
#define NAVEGADORWEB_HPP

#include "../Software.hpp"
#include <iostream>

class NavegadorWeb : public Software {
public:
    NavegadorWeb(HardwareArchitecture* arquitetura) : Software(arquitetura) {}

    void rodar() override {
        std::cout << "Abrindo Navegador Web..." << std::endl;
        arquitetura->executarInstrucao("carregar_pagina");
        arquitetura->executarInstrucao("renderizar_html");
    }
};

#endif
