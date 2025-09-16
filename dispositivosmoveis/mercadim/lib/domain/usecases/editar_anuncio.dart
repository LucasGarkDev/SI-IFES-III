import '../entities/anuncio.dart';
import '../repositories/anuncio_repository.dart';

class EditarAnuncio {
  final AnuncioRepository repo;
  const EditarAnuncio(this.repo);

  Future<Anuncio> call(Anuncio anuncio) {
    return repo.editarAnuncio(anuncio);
  }
}
