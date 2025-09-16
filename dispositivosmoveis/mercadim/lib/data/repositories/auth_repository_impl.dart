import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource ds;

  AuthRepositoryImpl(this.ds);

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty) throw const AppException('Nome é obrigatório');
    final u = await ds.createAccount(name: name, email: email, password: password);
    return u.toEntity();
  }

  @override
  Future<User?> currentUser() async => (await ds.current())?.toEntity();

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty) throw const AppException('E-mail é obrigatório');
    if (password.trim().isEmpty) throw const AppException('Senha é obrigatória');
    final u = await ds.login(email: email, password: password);
    return u.toEntity();
  }
}