// lib/presentation/viewmodels/feed_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/providers/usecase_providers.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../domain/usecases/listar_favoritos.dart';

/// ✅ Provider global para o Feed
final feedViewModelProvider =
    StateNotifierProvider<FeedViewModel, FeedState>((ref) {
  return FeedViewModel(
    ref.read(getAnunciosUseCaseProvider),
    ref.read(listarFavoritosProvider),
  );
});

/// ✅ ViewModel do Feed (UC11 - Visualizar Anúncios)
class FeedViewModel extends StateNotifier<FeedState> {
  final GetAnunciosUseCase _getAnuncios;
  final ListarFavoritos _listarFavoritos;

  FeedViewModel(this._getAnuncios, this._listarFavoritos)
      : super(FeedLoading());

  /// 🔹 Carrega anúncios de uma cidade específica (ou todos se vazio)
  Future<void> carregarAnuncios(String cidade) async {
    try {
      state = FeedLoading();
      final anuncios = await _getAnuncios(cidade);
      state = FeedSuccess(anuncios);
    } on AppException catch (e) {
      state = FeedError(e.mensagem);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios: $e');
    }
  }

  /// 🔹 Aplica múltiplos filtros (categoria, título, preço, favoritos)
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

      List<Anuncio> anuncios;

      // 1️⃣ Se for para mostrar apenas favoritos do usuário
      if (apenasFavoritos && userId != null) {
        anuncios = await _listarFavoritos(userId);
      } else {
        anuncios = await _getAnuncios(cidade ?? '');
      }

      // 2️⃣ Filtros locais adicionais
      if (titulo != null && titulo.trim().isNotEmpty) {
        final termo = titulo.trim().toLowerCase();
        anuncios = anuncios
            .where((a) => a.titulo.toLowerCase().contains(termo))
            .toList();
      }

      if (categoria != null && categoria.trim().isNotEmpty) {
        final termoCat = categoria.trim().toLowerCase();
        anuncios = anuncios
            .where((a) => a.categoria.toLowerCase().contains(termoCat))
            .toList();
      }

      if (cidade != null && cidade.trim().isNotEmpty) {
        final termoCidade = cidade.trim().toLowerCase();
        anuncios = anuncios
            .where((a) => a.cidade.toLowerCase().contains(termoCidade))
            .toList();
      }

      if (precoMin != null) {
        anuncios = anuncios.where((a) => a.preco >= precoMin).toList();
      }

      if (precoMax != null) {
        anuncios = anuncios.where((a) => a.preco <= precoMax).toList();
      }

      // ✅ Atualiza estado final
      state = FeedSuccess(anuncios);
    } on AppException catch (e) {
      state = FeedError(e.mensagem);
    } catch (e) {
      state = FeedError('Erro ao aplicar filtros: $e');
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
