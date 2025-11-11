// lib/presentation/viewmodels/feed_viewmodel.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/providers/usecase_providers.dart';
import '../../core/services/geofire_service.dart';
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
  final GeoFireService _geoService = GeoFireService(FirebaseFirestore.instance);

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

      state = FeedSuccess(anuncios);
    } on AppException catch (e) {
      state = FeedError(e.mensagem);
    } catch (e) {
      state = FeedError('Erro ao aplicar filtros: $e');
    }
  }

  /// 🌍 NOVO — Carrega anúncios próximos com base na localização do usuário.
  Future<void> carregarAnunciosProximos({double raioKm = 10}) async {
    try {
      state = FeedLoading();

      // 1️⃣ Solicita permissão e obtém localização atual
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = FeedError('Serviço de localização desativado.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = FeedError('Permissão de localização negada.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = FeedError('Permissão permanente negada.');
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 2️⃣ Busca anúncios dentro do raio informado
      final snapshot = await _geoService.buscarAnunciosPorRaio(
        latitude: pos.latitude,
        longitude: pos.longitude,
        raioKm: raioKm,
      );

      final anuncios = snapshot.map((doc) {
        final data = doc.data();
        return Anuncio(
          id: doc.id,
          titulo: data['titulo'] ?? '',
          descricao: data['descricao'] ?? '',
          preco: (data['preco'] ?? 0).toDouble(),
          categoria: data['categoria'] ?? '',
          cidade: data['cidade'] ?? '',
          bairro: data['bairro'] ?? '',
          dataCriacao: (data['dataCriacao'] is Timestamp)
              ? (data['dataCriacao'] as Timestamp).toDate()
              : DateTime.now(),
          imagemPrincipalUrl: data['imagemPrincipalUrl'] ?? '',
          usuarioId: data['usuarioId'] ?? '',
          destaque: data['destaque'] ?? false,
          imagens: (data['imagens'] as List?)?.cast<String>() ?? [],
        );
      }).toList();

      // 3️⃣ Ordena do mais próximo para o mais distante (opcional)
      anuncios.sort((a, b) {
        final distA = _geoService.calcularDistanciaKm(
          pos.latitude,
          pos.longitude,
          (a as dynamic).latitude ?? 0,
          (a as dynamic).longitude ?? 0,
        );
        final distB = _geoService.calcularDistanciaKm(
          pos.latitude,
          pos.longitude,
          (b as dynamic).latitude ?? 0,
          (b as dynamic).longitude ?? 0,
        );
        return distA.compareTo(distB);
      });

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios próximos: $e');
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
