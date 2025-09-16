import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/buscar_anuncios_por_titulo.dart';

abstract class BuscarState {}

class BuscarLoading extends BuscarState {}
class BuscarSuccess extends BuscarState {
  final List<Anuncio> anuncios;
  BuscarSuccess(this.anuncios);
}
class BuscarError extends BuscarState {
  final String mensagem;
  BuscarError(this.mensagem);
}
class BuscarIdle extends BuscarState {}

class BuscarAnunciosViewModel extends ChangeNotifier {
  final BuscarAnunciosPorTitulo _buscar;
  BuscarState state = BuscarIdle();

  BuscarAnunciosViewModel(this._buscar);

  Future<void> buscar(String termo) async {
    state = BuscarLoading();
    notifyListeners();
    try {
      final anuncios = await _buscar(termo);
      state = BuscarSuccess(anuncios);
      notifyListeners();
    } on AppException catch (e) {
      state = BuscarError(e.mensagem);
      notifyListeners();
    } catch (_) {
      state = BuscarError('Erro inesperado');
      notifyListeners();
    }
  }
}
