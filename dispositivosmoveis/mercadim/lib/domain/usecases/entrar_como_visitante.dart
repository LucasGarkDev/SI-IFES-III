import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class EntrarComoVisitante {
  final AuthRepository repo;
  const EntrarComoVisitante(this.repo);

  Future<User> call() => repo.entrarComoVisitante();
}
