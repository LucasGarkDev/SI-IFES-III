import '../entities/anuncio.dart';
import '../repositories/anuncio_repository.dart';

class BuscarAnunciosPorTitulo {
  final AnuncioRepository repo;
  const BuscarAnunciosPorTitulo(this.repo);

  Future<List<Anuncio>> call(String titulo) {
    return repo.buscarPorTitulo(titulo);
  }
}
