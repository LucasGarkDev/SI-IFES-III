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
import '../../data/models/anuncio_model.dart';
import 'package:geocoding/geocoding.dart';


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

  // CARREGAR NORMAL
  Future<void> carregarAnuncios(String cidade) async {
    try {
      state = FeedLoading();
      final anuncios = await _getAnuncios(cidade);
      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios: $e');
    }
  }

  Future<void> filtrarPorCidadeAtual() async {
    try {
      state = FeedLoading();

      // 🔹 Verifica serviços e permissões
      bool enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        state = FeedError('Serviço de localização desativado.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = FeedError('Permissão negada.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = FeedError('Permissão negada permanentemente.');
        return;
      }

      // 🔹 Obtém coordenadas
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 🔹 Converte em nome da cidade
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
        localeIdentifier: "pt_BR",
      );

      final cidade = placemarks.first.locality ??
          placemarks.first.subAdministrativeArea ??
          placemarks.first.administrativeArea ??
          "";

      if (cidade.isEmpty) {
        state = FeedError("Não foi possível identificar sua cidade.");
        return;
      }

      // 🔹 Busca anúncios somente da cidade encontrada
      final anuncios = await _getAnuncios(cidade);

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao localizar cidade: $e');
    }
  }


  // FILTRAR
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

      if (titulo != null && titulo.trim().isNotEmpty) {
        final termo = titulo.toLowerCase();
        anuncios = anuncios
            .where((a) => a.titulo.toLowerCase().contains(termo))
            .toList();
      }

      if (categoria != null && categoria.trim().isNotEmpty) {
        final termo = categoria.toLowerCase();
        anuncios = anuncios
            .where((a) => a.categoria.toLowerCase().contains(termo))
            .toList();
      }

      if (cidade != null && cidade.trim().isNotEmpty) {
        final termo = cidade.toLowerCase();
        anuncios = anuncios
            .where((a) => a.cidade.toLowerCase().contains(termo))
            .toList();
      }

      if (precoMin != null) {
        anuncios = anuncios.where((a) => a.preco >= precoMin).toList();
      }

      if (precoMax != null) {
        anuncios = anuncios.where((a) => a.preco <= precoMax).toList();
      }

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao aplicar filtros: $e');
    }
  }

  // 🌍 ANÚNCIOS PRÓXIMOS — CORRIGIDO E SEGURO
  Future<void> carregarAnunciosProximos({double raioKm = 10}) async {
    try {
      state = FeedLoading();

      // PERMISSÕES
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = FeedError('Serviço de localização desativado.');
        return;
      }

      LocationPermission p = await Geolocator.checkPermission();
      if (p == LocationPermission.denied) {
        p = await Geolocator.requestPermission();
        if (p == LocationPermission.denied) {
          state = FeedError('Permissão de localização negada.');
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

      // BUSCA
      final snapshot = await _geoService.buscarAnunciosPorRaio(
        latitude: pos.latitude,
        longitude: pos.longitude,
        raioKm: raioKm,
      );

      // CONVERTE MODELS → ENTITIES
      List<Anuncio> anuncios = snapshot.map((doc) {
        return AnuncioModel.fromMap(doc.data(), id: doc.id).toEntity();
      }).toList();

      // ORDENA POR DISTÂNCIA (SE TIVER LAT / LNG)
      anuncios.sort((a, b) {
        final aLat = a.latitude ?? 9999.0;
        final aLng = a.longitude ?? 9999.0;
        final bLat = b.latitude ?? 9999.0;
        final bLng = b.longitude ?? 9999.0;

        final distA = _geoService.calcularDistanciaKm(
          pos.latitude, pos.longitude, aLat, aLng,
        );
        final distB = _geoService.calcularDistanciaKm(
          pos.latitude, pos.longitude, bLat, bLng,
        );

        return distA.compareTo(distB);
      });

      state = FeedSuccess(anuncios);
    } catch (e) {
      state = FeedError('Erro ao carregar anúncios próximos: $e');
    }
  }
}

/// ESTADOS
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
