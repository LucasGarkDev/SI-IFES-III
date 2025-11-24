// lib/domain/usecases/listar_favoritos.dart
import '../entities/anuncio.dart';
import '../repositories/favorito_repository.dart';
import '../repositories/anuncio_repository.dart';

class ListarFavoritos {
  final FavoritoRepository favRepo;
  final AnuncioRepository anuncioRepo;

  const ListarFavoritos(this.favRepo, this.anuncioRepo);

  Future<List<Anuncio>> call(String usuarioId) async {
    // 1. Busca IDs dos anúncios favoritos no Firestore/Local Storage
    final ids = await favRepo.listarFavoritosIds(usuarioId);

    if (ids.isEmpty) return [];

    // 2. Busca os anúncios correspondentes por ID
    // (seu repo precisa ter esse método)
    final favoritos = <Anuncio>[];

    for (final id in ids) {
      final anuncio = await anuncioRepo.obterPorId(id);
      if (anuncio != null) {
        favoritos.add(anuncio);
      }
    }

    return favoritos;
  }
}
