import '../../domain/entities/localizacao_usuario.dart';

class LocalizacaoModel {
  final double latitude;
  final double longitude;
  final String? cidade;
  final String? bairro;

  LocalizacaoModel({
    required this.latitude,
    required this.longitude,
    this.cidade,
    this.bairro,
  });

  LocalizacaoUsuario toEntity() => LocalizacaoUsuario(
        latitude: latitude,
        longitude: longitude,
        cidade: cidade,
        bairro: bairro,
      );
}
