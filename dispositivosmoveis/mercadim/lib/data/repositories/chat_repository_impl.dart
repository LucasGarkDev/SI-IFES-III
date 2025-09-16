import '../../domain/entities/conversa.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_ds.dart';

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
}
