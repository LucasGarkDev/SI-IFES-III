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

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = _usersById.values.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => throw const AppException('Usuário não encontrado'),
    );

    final storedPass = _passwordByUserId[user.id];
    if (storedPass != password) {
      throw const AppException('Senha incorreta');
    }

    _current = user;
    return user;
  }

  Future<UserModel> updateProfile(UserModel updated) async {
    final exists = _usersById[updated.id];
    if (exists == null) {
      throw const AppException('Usuário não encontrado');
    }
    _usersById[updated.id] = updated;
    _current = updated;
    return updated;
  }

  Future<UserModel?> getById(String id) async {
    return _usersById[id];
  }

  Future<UserModel> entrarComoVisitante() async {
    final guest = UserModel(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Visitante',
      email: 'visitante@mercadim.com',
    );
    _current = guest;
    return guest;
  }
}