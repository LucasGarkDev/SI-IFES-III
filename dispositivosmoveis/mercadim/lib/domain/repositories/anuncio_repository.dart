import '../entities/anuncio.dart';

abstract class AnuncioRepository {
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade); // UC11
  Future<Anuncio> criarAnuncio(Anuncio anuncio);               // UC07

  Future<Anuncio> editarAnuncio(Anuncio anuncio);              // UC08
  Future<void> excluirAnuncio(String id);                      // UC10
  Future<List<Anuncio>> buscarPorTitulo(String titulo);          // UC16
  
  // 🔑 novo
  Future<List<Anuncio>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  });
}
