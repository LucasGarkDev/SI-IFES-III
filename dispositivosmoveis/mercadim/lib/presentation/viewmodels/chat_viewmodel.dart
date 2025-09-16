import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/mensagem.dart';
import '../../domain/usecases/enviar_mensagem.dart';

class ChatState {
  final List<Mensagem> mensagens;
  final bool loading;
  final String? error;

  const ChatState({this.mensagens = const [], this.loading = false, this.error});

  ChatState copy({List<Mensagem>? mensagens, bool? loading, String? error}) =>
      ChatState(
        mensagens: mensagens ?? this.mensagens,
        loading: loading ?? this.loading,
        error: error,
      );
}

class ChatViewModel extends ChangeNotifier {
  final EnviarMensagem _enviarMensagem;
  ChatState state = const ChatState();

  ChatViewModel(this._enviarMensagem);

  Future<void> enviarTexto({
    required String conversaId,
    required String usuarioId,
    required String conteudo,
  }) async {
    try {
      final msg = Mensagem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversaId: conversaId,
        remetenteId: usuarioId,
        tipo: TipoMensagem.texto,
        conteudo: conteudo,
        timestamp: DateTime.now(),
      );
      final enviado = await _enviarMensagem(msg);
      state = state.copy(mensagens: [...state.mensagens, enviado]);
      notifyListeners();
    } on AppException catch (e) {
      state = state.copy(error: e.mensagem);
      notifyListeners();
    }
  }
}
