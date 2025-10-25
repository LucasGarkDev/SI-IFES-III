import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signup_user.dart';

class SignUpState {
  final bool loading;
  final String? error;
  final User? created;

  const SignUpState({
    this.loading = false,
    this.error,
    this.created,
  });

  SignUpState copy({
    bool? loading,
    String? error,
    User? created,
  }) =>
      SignUpState(
        loading: loading ?? this.loading,
        error: error,
        created: created,
      );
}

class SignUpViewModel extends ChangeNotifier {
  final SignupUser _signup; // ✅ tipo atualizado
  SignUpState state = const SignUpState();

  SignUpViewModel(this._signup);

  // ===== Validações =====
  String? validateName(String? v) => Validators.required(v, field: 'Nome');
  String? validateEmail(String? v) => Validators.email(v);
  String? validatePassword(String? v) =>
      Validators.minLen(v, 4, field: 'Senha');

  // ===== Ação principal =====
  Future<User?> submit({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copy(loading: true, error: null, created: null);
    notifyListeners();
    try {
      // ✅ Criação de entidade User antes de enviar ao usecase Firestore
      final user = await _signup(
        User(
          id: '',
          name: name,
          email: email,
          city: null,
          photoUrl: null,
        ),
      );

      state = state.copy(loading: false, created: user);
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
