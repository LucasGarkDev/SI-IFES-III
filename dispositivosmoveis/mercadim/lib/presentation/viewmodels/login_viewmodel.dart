import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';

class LoginState {
  final bool loading;
  final String? error;
  final User? logged;

  const LoginState({this.loading = false, this.error, this.logged});

  LoginState copy({bool? loading, String? error, User? logged}) =>
      LoginState(
        loading: loading ?? this.loading,
        error: error,
        logged: logged,
      );
}

class LoginViewModel extends ChangeNotifier {
  final LoginUser _login;
  LoginState state = const LoginState();

  LoginViewModel(this._login);

  String? validateEmail(String? v) => Validators.email(v);
  String? validatePassword(String? v) =>
      Validators.minLen(v, 4, field: 'Senha');

  Future<User?> submit({
    required String email,
    required String password,
  }) async {
    state = state.copy(loading: true, error: null, logged: null);
    notifyListeners();
    try {
      final user = await _login(email: email, password: password);
      state = state.copy(loading: false, logged: user);
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
