import 'package:flutter/foundation.dart';
import '../../domain/usecases/toggle_favorito.dart';

class FavoritoViewModel extends ChangeNotifier {
  final ToggleFavorito _toggle;
  final String usuarioId;
  final Set<String> _favoritos = {};

  FavoritoViewModel(this._toggle, this.usuarioId);

  bool isFavorito(String anuncioId) => _favoritos.contains(anuncioId);

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
