import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/entrar_como_visitante.dart';
import '../../core/exceptions/app_exception.dart';

class VisitanteState {
  final bool loading;
  final String? error;
  final User? user;

  const VisitanteState({this.loading = false, this.error, this.user});

  VisitanteState copy({bool? loading, String? error, User? user}) =>
      VisitanteState(
        loading: loading ?? this.loading,
        error: error,
        user: user,
      );
}

class VisitanteViewModel extends ChangeNotifier {
  final EntrarComoVisitante _entrar;
  VisitanteState state = const VisitanteState();

  VisitanteViewModel(this._entrar);

  Future<User?> entrar() async {
    state = state.copy(loading: true, error: null, user: null);
    notifyListeners();
    try {
      final user = await _entrar();
      state = state.copy(loading: false, user: user);
      notifyListeners();
      return user;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    } catch (_) {
      state = state.copy(loading: false, error: 'Erro inesperado');
      notifyListeners();
      return null;
    }
  }
}
