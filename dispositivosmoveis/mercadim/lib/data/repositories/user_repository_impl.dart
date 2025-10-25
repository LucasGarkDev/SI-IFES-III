import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_firestore_ds.dart'; // ✅ Firestore em vez de local
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthFirestoreDataSource ds;
  UserRepositoryImpl(this.ds);

  /// Cria um novo usuário no Firestore
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

  /// Entrar como visitante (usa o método do datasource)
  Future<User> enterAsGuest() async {
    final guest = await ds.enterAsGuest();
    return guest.toEntity();
  }
}
