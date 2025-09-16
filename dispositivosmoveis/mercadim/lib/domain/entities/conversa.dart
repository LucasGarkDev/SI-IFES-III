class Conversa {
  final String id;
  final String usuario1Id;
  final String usuario2Id;
  final String anuncioId;
  final List<String> mensagens; // UC21 vai expandir com objeto Mensagem

  const Conversa({
    required this.id,
    required this.usuario1Id,
    required this.usuario2Id,
    required this.anuncioId,
    this.mensagens = const [],
  });
}
