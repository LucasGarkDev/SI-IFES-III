import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';

class FavoritoFirestoreDataSource {
  final FirebaseFirestore firestore;
  FavoritoFirestoreDataSource(this.firestore);

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('favoritos').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (data, _) => data,
          );

  /// Alterna favorito (adiciona se não existe; remove se existe).
  Future<void> toggleFavorito(String usuarioId, String anuncioId) async {
    try {
      final q = await _col
          .where('usuarioId', isEqualTo: usuarioId)
          .where('anuncioId', isEqualTo: anuncioId)
          .limit(1)
          .get();

      if (q.docs.isEmpty) {
        await _col.add({
          'usuarioId': usuarioId,
          'anuncioId': anuncioId,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } else {
        await _col.doc(q.docs.first.id).delete();
      }
    } catch (e) {
      throw AppException('Erro ao alternar favorito: $e');
    }
  }

  Future<List<String>> listarFavoritosIds(String usuarioId) async {
    try {
      final q = await _col.where('usuarioId', isEqualTo: usuarioId).get();
      return q.docs.map((d) => (d.data()['anuncioId'] as String)).toList();
    } catch (e) {
      throw AppException('Erro ao listar favoritos: $e');
    }
  }
}
