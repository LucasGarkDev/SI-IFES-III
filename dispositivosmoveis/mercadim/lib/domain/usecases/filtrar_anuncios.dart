import '../entities/anuncio.dart';
import '../repositories/anuncio_repository.dart';

class FiltrarAnuncios {
  final AnuncioRepository repo;
  const FiltrarAnuncios(this.repo);

  Future<List<Anuncio>> call({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) {
    return repo.filtrar(
      categoria: categoria,
      precoMin: precoMin,
      precoMax: precoMax,
      distanciaKm: distanciaKm,
      userLat: userLat,
      userLng: userLng,
    );
  }
}
