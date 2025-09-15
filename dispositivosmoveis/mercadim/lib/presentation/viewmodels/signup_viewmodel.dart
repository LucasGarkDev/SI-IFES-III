import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signup_user.dart';

class SignUpState {
  final bool loading;
  final String? error;
  final User? created;

  const SignUpState({this.loading = false, this.error, this.created});

  SignUpState copy({bool? loading, String? error, User? created}) =>
      SignUpState(
        loading: loading ?? this.loading,
        error: error,
        created: created,
      );
}

class SignUpViewModel extends ChangeNotifier {
  final SignUpUser _signUp;
  SignUpState state = const SignUpState();

  SignUpViewModel(this._signUp);

  String? validateName(String? v) => Validators.required(v, field: 'Nome');
  String? validateEmail(String? v) => Validators.email(v);
  String? validatePassword(String? v) =>
      Validators.minLen(v, 4, field: 'Senha');

  Future<User?> submit({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copy(loading: true, error: null, created: null);
    notifyListeners();
    try {
      final user = await _signUp(name: name, email: email, password: password);
      state = state.copy(loading: false, created: user);
      notifyListeners();
      return user;
    } on AppException catch (e) {
      // usamos 'mensagem' porque a nossa AppException define esse campo
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
