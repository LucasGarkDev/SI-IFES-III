import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_local_ds.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthLocalDataSource ds;
  UserRepositoryImpl(this.ds);

  @override
  Future<User> updateProfile(User user) async {
    final model = UserModel.fromEntity(user);
    final updated = await ds.updateProfile(model);
    return updated.toEntity();
  }

  @override
  Future<User> getById(String id) async {
    final found = await ds.getById(id);
    if (found == null) throw const AppException('Usuário não encontrado');
    return found.toEntity();
  }
}
