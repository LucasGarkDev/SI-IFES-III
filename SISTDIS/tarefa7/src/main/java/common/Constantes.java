/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package common;

/**
 *
 * @author lucas
 */
public class Constantes {
    // --- Configurações de rede ---
    public static final String HOST_SERVIDOR = "127.0.0.1"; // altere para IP real da máquina do servidor
    public static final int PORTA_TCP_SERVIDOR = 9090;
    public static final int PORTA_TCP_PEER = 9091;

    // --- Configurações Multicast ---
    public static final String GRUPO_MULTICAST = "230.0.0.1";
    public static final int PORTA_MULTICAST = 6789;

    // --- Configuração de dados ---
    public static final int NUM_USUARIOS = 5;
    public static final int NUM_ARTISTAS = 20;

    // --- Notas ---
    public static final int NAO_CONHECE = 0;
    public static final int NAO_GOSTA = 1;
    public static final int GOSTA_POUCO = 2;
    public static final int GOSTA_MUITO = 3;
    
    public static final String[] NOMES_ARTISTAS = {
        "The Beatles",
        "Queen",
        "Michael Jackson",
        "Madonna",
        "Nirvana",
        "Coldplay",
        "Imagine Dragons",
        "Linkin Park",
        "Eminem",
        "BTS",
        "Taylor Swift",
        "Ed Sheeran",
        "Metallica",
        "AC/DC",
        "The Weeknd",
        "Adele",
        "Arctic Monkeys",
        "Bruno Mars",
        "Billie Eilish",
        "Shakira"
    };
}
