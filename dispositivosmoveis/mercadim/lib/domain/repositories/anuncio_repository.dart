import '../entities/anuncio.dart';

abstract class AnuncioRepository {
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade); // UC11
  Future<Anuncio> criarAnuncio(Anuncio anuncio);               // UC07
}
