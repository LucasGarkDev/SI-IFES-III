// lib/core/services/geofire_service.dart
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Serviço simples de localização baseado em raio.
/// 100% compatível com Firestore 5.x, sem libs externas.
class GeoFireService {
  final FirebaseFirestore firestore;

  GeoFireService(this.firestore);

  /// Salva latitude e longitude no documento do anúncio.
  Future<void> salvarLocalizacaoAnuncio({
    required String anuncioId,
    required double latitude,
    required double longitude,
  }) async {
    await firestore.collection('anuncios').doc(anuncioId).set({
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  /// Retorna anúncios dentro de um raio (em km) a partir de um ponto.
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> buscarAnunciosPorRaio({
    required double latitude,
    required double longitude,
    double raioKm = 10,
  }) async {
    final collection = firestore.collection('anuncios');
    final snapshot = await collection.get();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> dentroDoRaio = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final lat = data['latitude'];
      final lng = data['longitude'];
      if (lat == null || lng == null) continue;

      final distancia = calcularDistanciaKm(latitude, longitude, lat, lng);
      if (distancia <= raioKm) {
        dentroDoRaio.add(doc);
      }
    }

    return dentroDoRaio;
  }

  /// Fórmula de Haversine — calcula distância entre duas coordenadas.
  double calcularDistanciaKm(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // raio da Terra em km
    final dLat = _grausParaRadianos(lat2 - lat1);
    final dLon = _grausParaRadianos(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_grausParaRadianos(lat1)) *
            cos(_grausParaRadianos(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _grausParaRadianos(double deg) => deg * (pi / 180);
}
