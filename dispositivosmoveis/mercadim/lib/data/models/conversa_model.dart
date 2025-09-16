import '../../domain/entities/conversa.dart';

class ConversaModel {
  final String id;
  final String usuario1Id;
  final String usuario2Id;
  final String anuncioId;
  final List<String> mensagens;

  ConversaModel({
    required this.id,
    required this.usuario1Id,
    required this.usuario2Id,
    required this.anuncioId,
    required this.mensagens,
  });

  Conversa toEntity() => Conversa(
        id: id,
        usuario1Id: usuario1Id,
        usuario2Id: usuario2Id,
        anuncioId: anuncioId,
        mensagens: mensagens,
      );
}
