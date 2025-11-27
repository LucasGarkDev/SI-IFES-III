// lib/presentation/viewmodels/feed_viewmodel.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/providers/usecase_providers.dart';
import '../../core/services/geofire_service.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../domain/usecases/listar_favoritos.dart';
import '../../data/models/anuncio_model.dart';

/// Provider global
final feedViewModelProvider =
    StateNotifierProvider<FeedViewModel, FeedState>((ref) {
  return FeedViewModel(
    ref.read(getAnunciosUseCaseProvider),
    ref.read(listarFavoritosProvider),
  );
});

class FeedViewModel extends StateNotifier<FeedState> {
  final GetAnunciosUseCase _getAnuncios;
  final ListarFavoritos _listarFavoritos;
  final GeoFireService _geoService = GeoFireService(FirebaseFirestore.instance);

  FeedViewModel(this._getAnuncios, this._listarFavoritos)
      : super(FeedLoading());

  // ============================================================
  // 🔹 Função auxiliar — extrai cidade com fallback robusto
  // ============================================================
  String _extrairCidade(List<Placemark> list) {
    final p = list.first;

    return p.locality?.trim().isNotEmpty == true
        ? p.locality!.trim()
        : p.subAdministrativeArea?.trim().isNotEmpty == true
            ? p.subAdministrativeArea!.trim()
            : p.subLocality?.trim().isNotEmpty == true
                ? p.subLocality!.trim()
                : p.administrativeArea?.trim().isNotEmpty == true
                    ? p.administrativeArea!.trim()
                    : "";
  }

  // ============================================================
  // 🔹 Carregar anúncios de uma cidade específica
  // ============================================================
  Future<void> carregarAnuncios(String cidade) async {
    try {
      state = FeedLoading();
      final anuncios = await _getAnuncios(cidade);
      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios: $e');
    }
  }

  // ============================================================
  // 🔥 Filtrar por cidade via localização atual
  // ============================================================
  Future<void> filtrarPorCidadeAtual() async {
    try {
      state = FeedLoading();

      // Permissões
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        state = FeedError('Serviço de localização desativado.');
        return;
      }

      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.denied) {
          state = FeedError('Permissão negada.');
          return;
        }
      }

      if (perm == LocationPermission.deniedForever) {
        state = FeedError('Permissão negada permanentemente.');
        return;
      }

      // Coordenadas do usuário
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Geocoding → cidade
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      final cidade = _extrairCidade(placemarks);

      if (cidade.isEmpty) {
        state = FeedError("Não foi possível identificar sua cidade.");
        return;
      }

      print("DEBUG → Cidade detectada: $cidade");

      final anuncios = await _getAnuncios(cidade);
      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao localizar cidade: $e');
    }
  }

  // ============================================================
  // 🔍 Filtrar anúncios (título, categoria, preço, favoritos)
  // ============================================================
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

      if (apenasFavoritos && userId != null) {
        anuncios = await _listarFavoritos(userId);
      } else {
        anuncios = await _getAnuncios(cidade ?? '');
      }

      // Título
      if (titulo != null && titulo.trim().isNotEmpty) {
        final t = titulo.toLowerCase();
        anuncios = anuncios.where((a) => a.titulo.toLowerCase().contains(t)).toList();
      }

      // Categoria
      if (categoria != null && categoria.trim().isNotEmpty) {
        final t = categoria.toLowerCase();
        anuncios = anuncios.where((a) => a.categoria.toLowerCase().contains(t)).toList();
      }

      // Cidade
      if (cidade != null && cidade.trim().isNotEmpty) {
        final t = cidade.toLowerCase();
        anuncios = anuncios.where((a) => a.cidade.toLowerCase().contains(t)).toList();
      }

      // Preço mínimo
      if (precoMin != null) {
        anuncios = anuncios.where((a) => a.preco >= precoMin).toList();
      }

      // Preço máximo
      if (precoMax != null) {
        anuncios = anuncios.where((a) => a.preco <= precoMax).toList();
      }

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao aplicar filtros: $e');
    }
  }

  // ============================================================
  // 🌍 Anúncios próximos usando GeoFire
  // ============================================================
  Future<void> carregarAnunciosProximos({double raioKm = 10}) async {
    try {
      state = FeedLoading();

      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        state = FeedError('Serviço de localização desativado.');
        return;
      }

      LocationPermission p = await Geolocator.checkPermission();
      if (p == LocationPermission.denied) {
        p = await Geolocator.requestPermission();
        if (p == LocationPermission.denied) {
          state = FeedError('Permissão negada.');
          return;
        }
      }

      if (p == LocationPermission.deniedForever) {
        state = FeedError('Permissão negada permanentemente.');
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final snapshot = await _geoService.buscarAnunciosPorRaio(
        latitude: pos.latitude,
        longitude: pos.longitude,
        raioKm: raioKm,
      );

      // Converte Firestore → Model → Entity
      List<Anuncio> anuncios = snapshot
          .map((doc) => AnuncioModel.fromMap(doc.data(), id: doc.id).toEntity())
          .toList();

      // Ordena por distância (caso tenha lat/lng)
      anuncios.sort((a, b) {
        final aLat = a.latitude ?? 9999.0;
        final aLng = a.longitude ?? 9999.0;
        final bLat = b.latitude ?? 9999.0;
        final bLng = b.longitude ?? 9999.0;

        final distA = _geoService.calcularDistanciaKm(pos.latitude, pos.longitude, aLat, aLng);
        final distB = _geoService.calcularDistanciaKm(pos.latitude, pos.longitude, bLat, bLng);

        return distA.compareTo(distB);
      });

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios próximos: $e');
    }
  }
}

////////////////////////////////////////////////////////////////
/// ESTADOS DO FEED
////////////////////////////////////////////////////////////////

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
