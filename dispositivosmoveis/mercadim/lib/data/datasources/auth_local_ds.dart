import '../../core/exceptions/app_exception.dart';
import '../../core/services/id_service.dart';
import '../models/user_model.dart';

/// DataSource in-memory apenas para o MVP.
class AuthLocalDataSource {
  final IdService _id;
  final Map<String, UserModel> _usersById = {};
  final Map<String, String> _passwordByUserId = {};
  UserModel? _current;

  AuthLocalDataSource(this._id);

  Future<UserModel> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final exists = _usersById.values
        .any((u) => u.email.toLowerCase() == email.toLowerCase());
    if (exists) throw const AppException('E-mail já cadastrado');

    if (password.trim().length < 4) {
      throw const AppException('Senha deve ter ao menos 4 caracteres');
    }

    final user = UserModel(
      id: _id.make('u_'),
      name: name.trim(),
      email: email.trim(),
    );
    _usersById[user.id] = user;
    _passwordByUserId[user.id] = password; // (sem hash no mock)
    _current = user;
    return user;
  }

  Future<UserModel?> current() async => _current;
}