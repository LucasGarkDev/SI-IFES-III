import '../entities/mensagem.dart';
import '../repositories/chat_repository.dart';

class EnviarMensagem {
  final ChatRepository repo;
  const EnviarMensagem(this.repo);

  Future<Mensagem> call(Mensagem mensagem) {
    return repo.enviarMensagem(mensagem);
  }
}
