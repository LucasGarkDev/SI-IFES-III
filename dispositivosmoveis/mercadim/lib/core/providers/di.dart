import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/auth_firestore_ds.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/signup_user.dart';

class DI {
  DI._();
  static final DI I = DI._();

  // 🔥 DataSource Firestore (autenticação / usuários)
  late final AuthFirestoreDataSource authDS =
      AuthFirestoreDataSource(FirebaseFirestore.instance);

  // 💾 Repositório de Usuários baseado no Firestore
  late final UserRepositoryImpl userRepo = UserRepositoryImpl(authDS);

  // 🧩 UC01 – Criar Conta (Signup)
  late final SignupUser signupUser = SignupUser(userRepo);
}
