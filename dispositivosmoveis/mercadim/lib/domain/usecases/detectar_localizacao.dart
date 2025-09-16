import '../entities/localizacao_usuario.dart';
import '../repositories/localizacao_repository.dart';

class DetectarLocalizacao {
  final LocalizacaoRepository repo;
  const DetectarLocalizacao(this.repo);

  Future<LocalizacaoUsuario> call() {
    return repo.detectarLocalizacao();
  }
}
