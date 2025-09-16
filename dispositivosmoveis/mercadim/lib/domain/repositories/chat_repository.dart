import '../entities/conversa.dart';
import '../entities/mensagem.dart';

abstract class ChatRepository {
  Future<Conversa> iniciarConversa({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  });

  Future<List<Conversa>> listarConversasDoUsuario(String usuarioId);

  Future<Mensagem> enviarMensagem(Mensagem mensagem);
  Future<List<Mensagem>> listarMensagens(String conversaId);
}
