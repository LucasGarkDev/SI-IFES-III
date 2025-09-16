import '../entities/anuncio.dart';
import '../repositories/favorito_repository.dart';
import '../repositories/anuncio_repository.dart';

class ListarFavoritos {
  final FavoritoRepository favRepo;
  final AnuncioRepository anuncioRepo;

  const ListarFavoritos(this.favRepo, this.anuncioRepo);

  Future<List<Anuncio>> call(String usuarioId) async {
    final ids = await favRepo.listarFavoritosIds(usuarioId);
    if (ids.isEmpty) return [];

    // busca todos anúncios (mock simplificado) e filtra
    // em produção, faríamos fetch por ID
    final todos = await anuncioRepo.obterAnunciosPorCidade('Baixo Guandu');
    return todos.where((a) => ids.contains(a.id)).toList();
  }
}
