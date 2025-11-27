// lib/data/datasources/anuncio_firestore_ds.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/anuncio_model.dart';
import 'anuncio_remote_data_source.dart';

class AnuncioRemoteDataSourceFirestore implements AnuncioRemoteDataSource {
  final FirebaseFirestore firestore;
  AnuncioRemoteDataSourceFirestore(this.firestore);

  CollectionReference<Map<String, dynamic>> get _col =>
    firestore.collection('anuncios');

  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade) async {
    try {
      print("DEBUG → cidade recebida no filtro: '$cidade'");
      final cidadeNorm = cidade.toLowerCase().trim();
      print("DEBUG → cidade normalizada: '$cidadeNorm'");

      Query<Map<String, dynamic>> q = _col;

      if (cidadeNorm.isNotEmpty) {
        q = q.where('cidade', isEqualTo: cidadeNorm);
      }

      final snapshot = await q.get();
      print("DEBUG → documentos retornados: ${snapshot.docs.length}");

      return snapshot.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao buscar anúncios: $e');
    }
  }

  @override
  Future<AnuncioModel?> obterPorId(String id) async {
    try {
      final doc = await _col.doc(id).get();

      if (!doc.exists) return null;

      return AnuncioModel.fromJson(doc.data()!).copyWith(id: doc.id);
    } catch (e) {
      throw AppException('Erro ao obter anúncio: $e');
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
        throw const AppException('ID do anúncio ausente.');
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
      final q = await _col
          .where('titulo', isGreaterThanOrEqualTo: titulo)
          .where('titulo', isLessThanOrEqualTo: '$titulo\uf8ff')
          .get();

      return q.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao buscar anúncios por título: $e');
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

      final snap = await q.get();
      return snap.docs
          .map((d) => AnuncioModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao filtrar anúncios: $e');
    }
  }
}
