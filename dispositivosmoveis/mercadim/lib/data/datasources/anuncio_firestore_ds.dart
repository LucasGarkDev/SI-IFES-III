import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/anuncio_model.dart';
import 'anuncio_remote_data_source.dart';

class AnuncioFirestoreDataSource implements AnuncioRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'anuncios';

  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String? cidade) async {
    try {
      print('[DEBUG] Buscando anúncios para cidade: $cidade');

      // Evita crash se cidade for nula ou vazia
      if (cidade == null || cidade.isEmpty) {
        throw AppException('Cidade do usuário não definida.');
      }

      final snapshot = await _firestore
          .collection(_collection)
          .where('cidade', isEqualTo: cidade)
          .get();

      print('[DEBUG] ${snapshot.docs.length} anúncios encontrados.');

      return snapshot.docs
          .map((doc) => AnuncioModel.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e, s) {
      print('[ERRO Firestore] $e\n$s');
      throw AppException('Erro ao buscar anúncios: $e');
    }
  }


  @override
  Future<AnuncioModel> criarAnuncio(AnuncioModel anuncio) async {
    try {
      // usa serverTimestamp para data de criação se quiser
      final data = anuncio.toMap();
      data['dataCriacao'] = FieldValue.serverTimestamp();

      final ref = await _firestore.collection(_collection).add(data);
      // opcional: ler o doc salvo para trazer a data do servidor
      final snap = await ref.get();
      final saved = AnuncioModel.fromMap(snap.data()!, id: ref.id);

      return saved;
    } catch (e) {
      throw AppException('Erro ao criar anúncio: $e');
    }
  }

  @override
  Future<AnuncioModel> editarAnuncio(AnuncioModel anuncio) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(anuncio.id)
          .update(anuncio.toMap());
      return anuncio;
    } catch (e) {
      throw AppException('Erro ao editar anúncio: $e');
    }
  }

  @override
  Future<void> excluirAnuncio(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw AppException('Erro ao excluir anúncio: $e');
    }
  }

    @override
  Future<List<AnuncioModel>> buscarPorTitulo(String titulo) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('titulo', isGreaterThanOrEqualTo: titulo)
          .where('titulo', isLessThanOrEqualTo: '$titulo\uf8ff')
          .get();

      return snapshot.docs
          .map((doc) => AnuncioModel.fromMap(doc.data(), id: doc.id))
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
      Query<Map<String, dynamic>> query =
          _firestore.collection(_collection);

      if (categoria != null && categoria.isNotEmpty) {
        query = query.where('categoria', isEqualTo: categoria);
      }
      if (precoMin != null) {
        query = query.where('preco', isGreaterThanOrEqualTo: precoMin);
      }
      if (precoMax != null) {
        query = query.where('preco', isLessThanOrEqualTo: precoMax);
      }

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => AnuncioModel.fromMap(doc.data(), id: doc.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao filtrar anúncios: $e');
    }
  }

}

