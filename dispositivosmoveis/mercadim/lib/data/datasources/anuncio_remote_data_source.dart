import '../models/anuncio_model.dart';

abstract class AnuncioRemoteDataSource {
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade);
}