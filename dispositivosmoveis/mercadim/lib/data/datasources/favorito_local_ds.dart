class FavoritoLocalDataSource {
  final Map<String, Set<String>> _favoritosPorUsuario = {};

  Future<void> toggleFavorito(String usuarioId, String anuncioId) async {
    final set = _favoritosPorUsuario.putIfAbsent(usuarioId, () => <String>{});
    if (set.contains(anuncioId)) {
      set.remove(anuncioId);
    } else {
      set.add(anuncioId);
    }
  }

  Future<List<String>> listarFavoritosIds(String usuarioId) async {
    return _favoritosPorUsuario[usuarioId]?.toList() ?? [];
  }
}
