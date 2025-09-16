import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/editar_anuncio.dart';

class EditarAnuncioState {
  final bool loading;
  final String? error;
  final Anuncio? updated;

  const EditarAnuncioState({this.loading = false, this.error, this.updated});

  EditarAnuncioState copy({bool? loading, String? error, Anuncio? updated}) =>
      EditarAnuncioState(
        loading: loading ?? this.loading,
        error: error,
        updated: updated,
      );
}

class EditarAnuncioViewModel extends ChangeNotifier {
  final EditarAnuncio _editarAnuncio;
  EditarAnuncioState state = const EditarAnuncioState();

  EditarAnuncioViewModel(this._editarAnuncio);

  String? validateTitulo(String? v) => Validators.required(v, field: 'Título');
  String? validatePreco(String? v) {
    if (v == null || v.trim().isEmpty) return 'Preço é obrigatório';
    if (double.tryParse(v) == null) return 'Preço inválido';
    return null;
  }

  Future<Anuncio?> submit(Anuncio anuncio) async {
    state = state.copy(loading: true, error: null, updated: null);
    notifyListeners();
    try {
      final updated = await _editarAnuncio(anuncio);
      state = state.copy(loading: false, updated: updated);
      notifyListeners();
      return updated;
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
