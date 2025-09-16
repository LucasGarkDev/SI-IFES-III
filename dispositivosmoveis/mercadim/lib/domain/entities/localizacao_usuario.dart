class LocalizacaoUsuario {
  final double latitude;
  final double longitude;
  final String? cidade;
  final String? bairro;

  const LocalizacaoUsuario({
    required this.latitude,
    required this.longitude,
    this.cidade,
    this.bairro,
  });
}
