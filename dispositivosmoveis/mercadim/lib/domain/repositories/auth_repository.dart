import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<User?> currentUser();
}