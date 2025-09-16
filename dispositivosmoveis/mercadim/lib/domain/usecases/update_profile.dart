import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateProfile {
  final UserRepository repo;
  const UpdateProfile(this.repo);

  Future<User> call(User user) => repo.updateProfile(user);
}
