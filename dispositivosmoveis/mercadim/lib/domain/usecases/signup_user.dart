// lib/domain/usecases/signup_user.dart
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignupUser {
  final UserRepository repository;

  const SignupUser(this.repository);

  Future<User> call(User user) async {
    return await repository.createUser(user);
  }
}
