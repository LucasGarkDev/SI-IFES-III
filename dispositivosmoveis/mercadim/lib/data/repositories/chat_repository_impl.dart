import '../../domain/entities/conversa.dart';
import '../../domain/entities/mensagem.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_ds.dart';
import '../models/mensagem_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource ds;
  ChatRepositoryImpl(this.ds);

  @override
  Future<Conversa> iniciarConversa({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  }) async {
    final model = await ds.iniciarConversa(
      usuarioAtualId: usuarioAtualId,
      vendedorId: vendedorId,
      anuncioId: anuncioId,
    );
    return model.toEntity();
  }

  @override
  Future<List<Conversa>> listarConversasDoUsuario(String usuarioId) async {
    final models = await ds.listarConversasDoUsuario(usuarioId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Mensagem> enviarMensagem(Mensagem mensagem) async {
    final model = MensagemModel(
      id: mensagem.id,
      conversaId: mensagem.conversaId,
      remetenteId: mensagem.remetenteId,
      tipo: mensagem.tipo,
      conteudo: mensagem.conteudo,
      timestamp: mensagem.timestamp,
    );
    final saved = await ds.enviarMensagem(model);
    return saved.toEntity();
  }

  @override
  Future<List<Mensagem>> listarMensagens(String conversaId) async {
    final models = await ds.listarMensagens(conversaId);
    return models.map((m) => m.toEntity()).toList();
  }
}
