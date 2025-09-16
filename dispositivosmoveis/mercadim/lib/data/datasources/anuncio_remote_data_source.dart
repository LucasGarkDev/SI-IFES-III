import '../models/anuncio_model.dart';

abstract class AnuncioRemoteDataSource {
  /// UC11 – Buscar anúncios por cidade
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade);

  /// UC07 – Criar novo anúncio
  Future<AnuncioModel> criarAnuncio(AnuncioModel anuncio);
   // 🔑 novo
  Future<AnuncioModel> editarAnuncio(AnuncioModel anuncio);
  Future<void> excluirAnuncio(String id);
  Future<List<AnuncioModel>> buscarPorTitulo(String titulo);

  Future<List<AnuncioModel>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  });
}

