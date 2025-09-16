import '../../domain/repositories/favorito_repository.dart';
import '../datasources/favorito_local_ds.dart';

class FavoritoRepositoryImpl implements FavoritoRepository {
  final FavoritoLocalDataSource ds;
  FavoritoRepositoryImpl(this.ds);

  @override
  Future<void> toggleFavorito(String usuarioId, String anuncioId) {
    return ds.toggleFavorito(usuarioId, anuncioId);
  }

  @override
  Future<List<String>> listarFavoritosIds(String usuarioId) {
    return ds.listarFavoritosIds(usuarioId);
  }
}
