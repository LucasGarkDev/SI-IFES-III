import '../entities/conversa.dart';

abstract class ChatRepository {
  Future<Conversa> iniciarConversa({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  });

  Future<List<Conversa>> listarConversasDoUsuario(String usuarioId);
}
