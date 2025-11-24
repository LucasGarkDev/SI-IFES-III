import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/anuncio_model.dart';
import 'anuncio_remote_data_source.dart';
import '../../domain/entities/anuncio.dart';


class AnuncioRemoteDataSourceFirestore implements AnuncioRemoteDataSource {
  final FirebaseFirestore firestore;
  AnuncioRemoteDataSourceFirestore(this.firestore);

  CollectionReference<Map<String, dynamic>> get _col =>
    firestore.collection('anuncios');

  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade) async {
    try {
      Query<Map<String, dynamic>> q = _col;
      if (cidade.isNotEmpty) {
        q = q.where('cidade', isEqualTo: cidade);
      }

      final snapshot = await q.get();

      return snapshot.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao buscar anúncios: $e');
    }
  }


  @override
  Future<AnuncioModel> criarAnuncio(AnuncioModel anuncio) async {
    try {
      final data = anuncio.toJson();
      final doc = await _col.add(data);
      return anuncio.copyWith(id: doc.id);
    } catch (e) {
      throw AppException('Erro ao criar anúncio: $e');
    }
  }

  @override
  Future<AnuncioModel> editarAnuncio(AnuncioModel anuncio) async {
    try {
      if (anuncio.id.isEmpty) {
        throw const AppException('ID do anúncio ausente para edição.');
      }
      await _col.doc(anuncio.id).update(anuncio.toJson());
      return anuncio;
    } catch (e) {
      throw AppException('Erro ao editar anúncio: $e');
    }
  }

  @override
  Future<void> excluirAnuncio(String id) async {
    try {
      await _col.doc(id).delete();
    } catch (e) {
      throw AppException('Erro ao excluir anúncio: $e');
    }
  }

  @override
  Future<List<AnuncioModel>> buscarPorTitulo(String titulo) async {
    try {
      // Busca por prefixo (case-sensitive); se quiser case-insensitive, normalize e salve outro campo.
      final q = await _col
          .where('titulo', isGreaterThanOrEqualTo: titulo)
          .where('titulo', isLessThanOrEqualTo: '$titulo\uf8ff')
          .get();
      return q.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao buscar por título: $e');
    }
  }

  @override
  Future<List<AnuncioModel>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) async {
    try {
      Query<Map<String, dynamic>> q = _col;

      if (categoria != null && categoria.isNotEmpty) {
        q = q.where('categoria', isEqualTo: categoria);
      }
      if (precoMin != null) {
        q = q.where('preco', isGreaterThanOrEqualTo: precoMin);
      }
      if (precoMax != null) {
        q = q.where('preco', isLessThanOrEqualTo: precoMax);
      }
      // Distância real exige geohash/geoqueries; mantemos fora por ora.

      final snap = await q.get();
      return snap.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao filtrar anúncios: $e');
    }
  }

  Future<Anuncio?> obterPorId(String id) async {
    final doc = await firestore.collection("anuncios").doc(id).get();

    if (!doc.exists) return null;

    final data = doc.data()!;
    return Anuncio.fromMap(doc.id, data);
  }

}
