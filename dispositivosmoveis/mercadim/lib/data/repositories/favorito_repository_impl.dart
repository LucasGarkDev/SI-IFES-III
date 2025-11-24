import '../../domain/repositories/favorito_repository.dart';
import '../datasources/favorito_firestore_ds.dart';

class FavoritoRepositoryImpl extends FavoritoRepository {
  final FavoritoFirestoreDataSource datasource;

  FavoritoRepositoryImpl(this.datasource);

  @override
  Future<void> toggleFavorito(String usuarioId, String anuncioId) {
    return datasource.toggleFavorito(usuarioId, anuncioId);
  }

  @override
  Future<List<String>> listarFavoritosIds(String usuarioId) {
    return datasource.listarFavoritosIds(usuarioId);
  }
}
