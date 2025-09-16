import '../models/conversa_model.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/conversa_model.dart';
import '../models/mensagem_model.dart';

/// DataSource in-memory para gerenciar conversas.
/// Funciona como mock no MVP.
class ChatLocalDataSource {
  final List<ConversaModel> _storage = [];
  final List<ConversaModel> _conversas = [];
  final List<MensagemModel> _mensagens = [];

  Future<ConversaModel> iniciarConversa({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  }) async {
    // procura conversa já existente entre os dois usuários e o anúncio
    try {
      final existing = _storage.firstWhere(
        (c) =>
            ((c.usuario1Id == usuarioAtualId && c.usuario2Id == vendedorId) ||
             (c.usuario1Id == vendedorId && c.usuario2Id == usuarioAtualId)) &&
            c.anuncioId == anuncioId,
      );
      return existing;
    } catch (_) {
      // não encontrou → cria uma nova
      final conversa = ConversaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        usuario1Id: usuarioAtualId,
        usuario2Id: vendedorId,
        anuncioId: anuncioId,
        mensagens: [],
      );
      _storage.add(conversa);
      return conversa;
    }
  }

  Future<List<ConversaModel>> listarConversasDoUsuario(String usuarioId) async {
    return _storage
        .where((c) => c.usuario1Id == usuarioId || c.usuario2Id == usuarioId)
        .toList();
  }

  Future<MensagemModel> enviarMensagem(MensagemModel msg) async {
    _mensagens.add(msg);
    return msg;
  }

  Future<List<MensagemModel>> listarMensagens(String conversaId) async {
    return _mensagens.where((m) => m.conversaId == conversaId).toList();
  }

}
