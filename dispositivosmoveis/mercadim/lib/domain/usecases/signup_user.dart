import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUser {
  final AuthRepository repo;
  const SignUpUser(this.repo);

  Future<User> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repo.signUp(name: name, email: email, password: password);
  }
}