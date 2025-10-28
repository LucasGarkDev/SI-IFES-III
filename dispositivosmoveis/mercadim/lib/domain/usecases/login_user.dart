// lib/domain/usecases/login_user.dart
import '../../core/exceptions/app_exception.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;
  const LoginUser(this.repository);

  // Por ora, senha não é validada (sem FirebaseAuth). Usamos o e-mail.
  Future<User> call({required String email, required String password}) async {
    final user = await repository.findByEmail(email);
    if (user == null) {
      throw const AppException('E-mail não encontrado.');
    }
    return user;
  }
}
