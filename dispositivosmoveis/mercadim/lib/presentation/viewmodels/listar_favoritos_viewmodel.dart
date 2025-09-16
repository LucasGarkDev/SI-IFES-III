import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/listar_favoritos.dart';

abstract class FavoritosState {}
class FavoritosLoading extends FavoritosState {}
class FavoritosSuccess extends FavoritosState {
  final List<Anuncio> anuncios;
  FavoritosSuccess(this.anuncios);
}
class FavoritosError extends FavoritosState {
  final String mensagem;
  FavoritosError(this.mensagem);
}
class FavoritosIdle extends FavoritosState {}

class ListarFavoritosViewModel extends ChangeNotifier {
  final ListarFavoritos _listar;
  FavoritosState state = FavoritosIdle();

  ListarFavoritosViewModel(this._listar);

  Future<void> carregar(String usuarioId) async {
    state = FavoritosLoading();
    notifyListeners();
    try {
      final anuncios = await _listar(usuarioId);
      state = FavoritosSuccess(anuncios);
      notifyListeners();
    } on AppException catch (e) {
      state = FavoritosError(e.mensagem);
      notifyListeners();
    } catch (_) {
      state = FavoritosError('Erro inesperado');
      notifyListeners();
    }
  }
}
