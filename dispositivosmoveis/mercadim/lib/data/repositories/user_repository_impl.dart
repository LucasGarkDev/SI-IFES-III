import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_firestore_ds.dart'; // Firestore DataSource
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthFirestoreDataSource ds;
  UserRepositoryImpl(this.ds);

  @override
  Future<User> createUser(User user) async {
    try {
      final model = UserModel.fromEntity(user);
      final created = await ds.createUser(model);
      return created.toEntity();
    } catch (e) {
      throw AppException('Erro ao criar usuário: $e');
    }
  }

  @override
  Future<User> updateProfile(User user) async {
    try {
      final model = UserModel.fromEntity(user);
      final updated = await ds.updateProfile(model);
      return updated.toEntity();
    } catch (e) {
      throw AppException('Erro ao atualizar perfil: $e');
    }
  }

  @override
  Future<User> getById(String id) async {
    final found = await ds.getById(id);
    if (found == null) throw const AppException('Usuário não encontrado');
    return found.toEntity();
  }

  @override
  Future<User> enterAsGuest() async {
    final guest = await ds.enterAsGuest();
    return guest.toEntity();
  }

  // ✅ Implementação para login via e-mail
  @override
  Future<User?> findByEmail(String email) async {
    try {
      final found = await ds.findByEmail(email);
      return found?.toEntity();
    } catch (e) {
      throw AppException('Erro ao buscar usuário: $e');
    }
  }
}
