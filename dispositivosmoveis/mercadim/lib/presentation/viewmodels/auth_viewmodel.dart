import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signup_user.dart';
import '../../domain/usecases/entrar_como_visitante.dart';
import '../../domain/usecases/login_user.dart';
import '../../core/exceptions/app_exception.dart';

class AuthState {
  final bool loading;
  final String? error;
  final User? user;

  const AuthState({
    this.loading = false,
    this.error,
    this.user,
  });

  bool get isVisitante => user?.email == 'visitante@mercadim.com';
  bool get isLogado => user != null && !isVisitante;

  AuthState copy({
    bool? loading,
    String? error,
    User? user,
  }) =>
      AuthState(
        loading: loading ?? this.loading,
        error: error,
        user: user ?? this.user,
      );
}

class AuthViewModel extends ChangeNotifier {
  final SignUpUser _signUp;
  final EntrarComoVisitante _entrarVisitante;
  final LoginUser _login;

  AuthState state = const AuthState();

  AuthViewModel(this._signUp, this._entrarVisitante, this._login);

  Future<User?> criarConta(String name, String email, String senha) async {
    state = state.copy(loading: true, error: null);
    notifyListeners();
    try {
      final user = await _signUp(name: name, email: email, password: senha);
      state = state.copy(loading: false, user: user);
      notifyListeners();
      return user;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    }
  }

  Future<User?> login(String email, String senha) async {
    state = state.copy(loading: true, error: null);
    notifyListeners();
    try {
      final user = await _login(email: email, password: senha);
      state = state.copy(loading: false, user: user);
      notifyListeners();
      return user;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    }
  }

  Future<User?> entrarComoVisitante() async {
    state = state.copy(loading: true, error: null);
    notifyListeners();
    try {
      final user = await _entrarVisitante();
      state = state.copy(loading: false, user: user);
      notifyListeners();
      return user;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    }
  }

  void logout() {
    state = const AuthState(user: null);
    notifyListeners();
  }
}
