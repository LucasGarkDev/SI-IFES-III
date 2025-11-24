import 'package:flutter/foundation.dart';
import '../../domain/usecases/toggle_favorito.dart';

class FavoritoViewModel extends ChangeNotifier {
  final ToggleFavorito _toggle;
  final String usuarioId;

  // Agora o estado é preparado para carregamento externo
  final Set<String> _favoritos = {};

  FavoritoViewModel(this._toggle, this.usuarioId);

  // Expor favoritos como somente leitura
  Set<String> get favoritos => _favoritos;

  // Marca se o anúncio é favorito
  bool isFavorito(String anuncioId) => _favoritos.contains(anuncioId);

  // Novo método: inicializa os favoritos reais vindos do Firestore
  Future<void> carregarFavoritos(List<String> lista) async {
    _favoritos
      ..clear()
      ..addAll(lista);
    notifyListeners();
  }

  // Alterna favorito
  Future<void> toggle(String anuncioId) async {
    await _toggle(usuarioId, anuncioId);

    if (_favoritos.contains(anuncioId)) {
      _favoritos.remove(anuncioId);
    } else {
      _favoritos.add(anuncioId);
    }

    notifyListeners();
  }
}
