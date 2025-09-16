import '../repositories/anuncio_repository.dart';

class ExcluirAnuncio {
  final AnuncioRepository repo;
  const ExcluirAnuncio(this.repo);

  Future<void> call(String id) => repo.excluirAnuncio(id);
}