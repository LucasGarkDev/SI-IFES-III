import '../entities/anuncio.dart';
import '../repositories/anuncio_repository.dart';

class CriarAnuncio {
  final AnuncioRepository repo;
  const CriarAnuncio(this.repo);

  Future<Anuncio> call(Anuncio anuncio) {
    return repo.criarAnuncio(anuncio);
  }
}
