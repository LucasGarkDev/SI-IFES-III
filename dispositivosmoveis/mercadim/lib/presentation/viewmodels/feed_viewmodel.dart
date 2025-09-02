import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercadim/core/exceptions/app_exception.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';

final feedViewModelProvider = StateNotifierProvider<FeedViewModel, FeedState>(
  (ref) => FeedViewModel(ref.read(getAnunciosUseCaseProvider)),
);

class FeedViewModel extends StateNotifier<FeedState> {
  final GetAnunciosUseCase _getAnuncios;

  FeedViewModel(this._getAnuncios) : super(FeedLoading());

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
}

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
