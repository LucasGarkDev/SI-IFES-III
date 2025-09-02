class AppException implements Exception {
  final String mensagem;

  AppException(this.mensagem);

  @override
  String toString() => mensagem;
}
