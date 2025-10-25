import '../entities/user.dart';

abstract class UserRepository {
  Future<User> createUser(User user);
  Future<User> updateProfile(User user);
  Future<User> getById(String id);
  Future<User> enterAsGuest();
}
