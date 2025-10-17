import '../models/anuncio_model.dart';

abstract class AnuncioRemoteDataSource {
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade);
  Future<AnuncioModel> criarAnuncio(AnuncioModel anuncio);
  Future<AnuncioModel> editarAnuncio(AnuncioModel anuncio);
  Future<void> excluirAnuncio(String id);

  // (opcionais, caso você já use)
  Future<List<AnuncioModel>> buscarPorTitulo(String titulo) async =>
      Future.value(<AnuncioModel>[]);
  Future<List<AnuncioModel>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) async => Future.value(<AnuncioModel>[]);
}


