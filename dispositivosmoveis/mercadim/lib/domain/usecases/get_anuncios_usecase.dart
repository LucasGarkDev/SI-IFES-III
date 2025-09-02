import '../entities/anuncio.dart';
import '../repositories/anuncio_repository.dart';

class GetAnunciosUseCase {
  final AnuncioRepository repository;

  GetAnunciosUseCase(this.repository);

  Future<List<Anuncio>> call(String cidade) {
    return repository.obterAnunciosPorCidade(cidade);
  }
}