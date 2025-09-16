import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/localizacao_usuario.dart';
import '../../domain/usecases/detectar_localizacao.dart';

class LocalizacaoState {
  final bool loading;
  final String? error;
  final LocalizacaoUsuario? localizacao;

  const LocalizacaoState({this.loading = false, this.error, this.localizacao});

  LocalizacaoState copy({
    bool? loading,
    String? error,
    LocalizacaoUsuario? localizacao,
  }) =>
      LocalizacaoState(
        loading: loading ?? this.loading,
        error: error,
        localizacao: localizacao,
      );
}

class LocalizacaoViewModel extends ChangeNotifier {
  final DetectarLocalizacao _detectar;
  LocalizacaoState state = const LocalizacaoState();

  LocalizacaoViewModel(this._detectar);

  Future<void> detectar() async {
    state = state.copy(loading: true, error: null, localizacao: null);
    notifyListeners();
    try {
      final loc = await _detectar();
      state = state.copy(loading: false, localizacao: loc);
      notifyListeners();
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
    } catch (_) {
      state = state.copy(loading: false, error: 'Erro inesperado');
      notifyListeners();
    }
  }
}
