import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../domain/entities/conversa.dart';
import '../../domain/usecases/iniciar_conversa.dart';

class IniciarConversaState {
  final bool loading;
  final String? error;
  final Conversa? conversa;

  const IniciarConversaState({this.loading = false, this.error, this.conversa});

  IniciarConversaState copy({
    bool? loading,
    String? error,
    Conversa? conversa,
  }) =>
      IniciarConversaState(
        loading: loading ?? this.loading,
        error: error,
        conversa: conversa,
      );
}

class IniciarConversaViewModel extends ChangeNotifier {
  final IniciarConversa _iniciar;
  IniciarConversaState state = const IniciarConversaState();

  IniciarConversaViewModel(this._iniciar);

  Future<Conversa?> submit({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  }) async {
    state = state.copy(loading: true, error: null, conversa: null);
    notifyListeners();
    try {
      final conversa = await _iniciar(
        usuarioAtualId: usuarioAtualId,
        vendedorId: vendedorId,
        anuncioId: anuncioId,
      );
      state = state.copy(loading: false, conversa: conversa);
      notifyListeners();
      return conversa;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    } catch (_) {
      state = state.copy(loading: false, error: 'Erro inesperado');
      notifyListeners();
      return null;
    }
  }
}
