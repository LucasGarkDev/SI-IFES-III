import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/usecases/excluir_anuncio.dart';

class ExcluirAnuncioState {
  final bool loading;
  final String? error;
  final bool success;

  const ExcluirAnuncioState({
    this.loading = false,
    this.error,
    this.success = false,
  });

  ExcluirAnuncioState copy({
    bool? loading,
    String? error,
    bool? success,
  }) =>
      ExcluirAnuncioState(
        loading: loading ?? this.loading,
        error: error,
        success: success ?? this.success,
      );
}

class ExcluirAnuncioViewModel extends ChangeNotifier {
  final ExcluirAnuncio _excluir;
  ExcluirAnuncioState state = const ExcluirAnuncioState();

  ExcluirAnuncioViewModel(this._excluir);

  Future<bool> submit(String id) async {
    state = state.copy(loading: true, error: null, success: false);
    notifyListeners();
    try {
      await _excluir(id);
      state = state.copy(loading: false, success: true);
      notifyListeners();
      return true;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return false;
    } catch (_) {
      state = state.copy(loading: false, error: 'Erro inesperado');
      notifyListeners();
      return false;
    }
  }
}
