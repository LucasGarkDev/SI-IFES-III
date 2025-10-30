/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.locadora.backend.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI locadoraOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("🎬 API - Sistema Locadora de Vídeos")
                        .description("Documentação completa da API da Locadora.\n\n" +
                                "Endpoints de gerenciamento de atores, diretores, classes, títulos, clientes e itens.")
                        .version("1.0.0")
                        .contact(new Contact()
                                .name("Equipe Locadora Devs")
                                .email("contato@locadora.dev.br")
                                .url("https://github.com/seu-repo"))
                        .license(new License()
                                .name("Apache 2.0")
                                .url("https://www.apache.org/licenses/LICENSE-2.0.html"))
                )
                .servers(List.of(
                        new Server().url("http://localhost:8080").description("Servidor Local")
                ));
    }
}

