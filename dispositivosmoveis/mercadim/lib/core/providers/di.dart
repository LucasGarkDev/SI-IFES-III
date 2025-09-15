import '../../data/datasources/auth_local_ds.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/signup_user.dart';
import '../services/id_service.dart';

class DI {
  DI._();
  static final DI I = DI._();

  late final IdService id = IdService();
  late final AuthLocalDataSource authDS = AuthLocalDataSource(id);
  late final AuthRepositoryImpl authRepo = AuthRepositoryImpl(authDS);

  // UC01
  late final SignUpUser signUpUser = SignUpUser(authRepo);
}
