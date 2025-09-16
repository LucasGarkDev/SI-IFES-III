import '../repositories/favorito_repository.dart';

class ToggleFavorito {
  final FavoritoRepository repo;
  const ToggleFavorito(this.repo);

  Future<void> call(String usuarioId, String anuncioId) {
    return repo.toggleFavorito(usuarioId, anuncioId);
  }
}
