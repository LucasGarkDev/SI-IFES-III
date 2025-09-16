import '../entities/localizacao_usuario.dart';

abstract class LocalizacaoRepository {
  Future<LocalizacaoUsuario> detectarLocalizacao();
}