class AppException implements Exception {
  final String mensagem;
  const AppException(this.mensagem);
  @override
  String toString() => mensagem;
}