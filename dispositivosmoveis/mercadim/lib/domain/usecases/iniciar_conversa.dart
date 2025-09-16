import '../entities/conversa.dart';
import '../repositories/chat_repository.dart';

class IniciarConversa {
  final ChatRepository repo;
  const IniciarConversa(this.repo);

  Future<Conversa> call({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  }) {
    return repo.iniciarConversa(
      usuarioAtualId: usuarioAtualId,
      vendedorId: vendedorId,
      anuncioId: anuncioId,
    );
  }
}
