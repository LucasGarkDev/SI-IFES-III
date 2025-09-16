import '../entities/user.dart';

abstract class UserRepository {
  Future<User> updateProfile(User user);
  Future<User> getById(String id);
}
