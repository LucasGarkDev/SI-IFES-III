import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/criar_anuncio.dart';

class CriarAnuncioState {
  final bool loading;
  final String? error;
  final Anuncio? created;

  const CriarAnuncioState({this.loading = false, this.error, this.created});

  CriarAnuncioState copy({bool? loading, String? error, Anuncio? created}) =>
      CriarAnuncioState(
        loading: loading ?? this.loading,
        error: error,
        created: created,
      );
}

class CriarAnuncioViewModel extends ChangeNotifier {
  final CriarAnuncio _criarAnuncio;
  CriarAnuncioState state = const CriarAnuncioState();

  CriarAnuncioViewModel(this._criarAnuncio);

  String? validateTitulo(String? v) => Validators.required(v, field: 'Título');
  String? validatePreco(String? v) {
    if (v == null || v.trim().isEmpty) return 'Preço é obrigatório';
    if (double.tryParse(v) == null) return 'Preço inválido';
    return null;
  }

  Future<Anuncio?> submit(Anuncio anuncio) async {
    state = state.copy(loading: true, error: null, created: null);
    notifyListeners();
    try {
      final created = await _criarAnuncio(anuncio);
      state = state.copy(loading: false, created: created);
      notifyListeners();
      return created;
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
