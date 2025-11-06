// lib/presentation/viewmodels/feed_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/providers/usecase_providers.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../domain/usecases/filtrar_anuncios.dart';
import '../../domain/usecases/listar_favoritos.dart';

/// Provider exposto para a UI
final feedViewModelProvider =
    StateNotifierProvider<FeedViewModel, FeedState>(
  (ref) => FeedViewModel(
    ref.read(getAnunciosUseCaseProvider),
    ref.read(filtrarAnunciosProvider),
    ref.read(listarFavoritosProvider),
  ),
);

/// ViewModel do Feed (UC11 - Visualizar Anúncios no Feed)
class FeedViewModel extends StateNotifier<FeedState> {
  final GetAnunciosUseCase _getAnuncios;
  final FiltrarAnuncios _filtrarAnuncios;
  final ListarFavoritos _listarFavoritos;

  FeedViewModel(
    this._getAnuncios,
    this._filtrarAnuncios,
    this._listarFavoritos,
  ) : super(FeedLoading());

  /// 🔹 Carrega anúncios por cidade (modo simples, compatível com versões antigas)
  Future<void> carregarAnuncios(String cidade) async {
    try {
      state = FeedLoading();
      final anuncios = await _getAnuncios(cidade);
      state = FeedSuccess(anuncios);
    } on AppException catch (e) {
      state = FeedError(e.mensagem);
    } catch (_) {
      state = FeedError('Erro inesperado ao carregar anúncios.');
    }
  }

  /// 🔹 Aplica múltiplos filtros combinados
  Future<void> filtrar({
    String? titulo,
    String? categoria,
    String? cidade,
    double? precoMin,
    double? precoMax,
    bool apenasFavoritos = false,
    String? userId,
  }) async {
    try {
      state = FeedLoading();

      // 1️⃣ Consulta inicial no Firestore com filtros básicos
      var anuncios = await _filtrarAnuncios(
        categoria: categoria?.isEmpty ?? true ? null : categoria,
        precoMin: precoMin,
        precoMax: precoMax,
      );

      // 2️⃣ Filtra por título (client-side)
      if (titulo != null && titulo.trim().isNotEmpty) {
        final termo = titulo.trim().toLowerCase();
        anuncios = anuncios
            .where((a) => a.titulo.toLowerCase().contains(termo))
            .toList();
      }

      // 3️⃣ Se quiser apenas favoritos e houver usuário logado
      if (apenasFavoritos && userId != null) {
        final favoritosIds = await _listarFavoritos(userId);
        anuncios = anuncios
            .where((a) => favoritosIds.any((fav) => fav.id == a.id))
            .toList();
      }

      state = FeedSuccess(anuncios);
    } on AppException catch (e) {
      state = FeedError(e.mensagem);
    } catch (e) {
      state = FeedError('Erro inesperado ao filtrar anúncios: $e');
    }
  }
}

/// Estados possíveis do Feed
abstract class FeedState {}

class FeedLoading extends FeedState {}

class FeedSuccess extends FeedState {
  final List<Anuncio> anuncios;
  FeedSuccess(this.anuncios);
}

class FeedError extends FeedState {
  final String mensagem;
  FeedError(this.mensagem);
}
