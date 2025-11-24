// lib/domain/repositories/favorito_repository.dart
abstract class FavoritoRepository {
  Future<void> toggleFavorito(String usuarioId, String anuncioId);
  Future<List<String>> listarFavoritosIds(String usuarioId);
  
}

