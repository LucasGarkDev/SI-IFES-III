import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/filtrar_anuncios.dart';

abstract class FiltroState {}

class FiltroIdle extends FiltroState {}
class FiltroLoading extends FiltroState {}
class FiltroSuccess extends FiltroState {
  final List<Anuncio> anuncios;
  FiltroSuccess(this.anuncios);
}
class FiltroError extends FiltroState {
  final String mensagem;
  FiltroError(this.mensagem);
}

class FiltrarAnunciosViewModel extends ChangeNotifier {
  final FiltrarAnuncios _filtrar;
  FiltroState state = FiltroIdle();

  FiltrarAnunciosViewModel(this._filtrar);

  Future<void> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) async {
    state = FiltroLoading();
    notifyListeners();
    try {
      final result = await _filtrar(
        categoria: categoria,
        precoMin: precoMin,
        precoMax: precoMax,
        distanciaKm: distanciaKm,
        userLat: userLat,
        userLng: userLng,
      );
      state = FiltroSuccess(result);
      notifyListeners();
    } on AppException catch (e) {
      state = FiltroError(e.mensagem);
      notifyListeners();
    } catch (_) {
      state = FiltroError('Erro inesperado');
      notifyListeners();
    }
  }
}
