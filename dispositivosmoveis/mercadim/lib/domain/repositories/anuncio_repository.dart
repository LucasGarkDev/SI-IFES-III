import '../entities/anuncio.dart';

abstract class AnuncioRepository {
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade);
}