import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/conversa_model.dart';
import '../models/mensagem_model.dart';

class ChatFirestoreDataSource {
  final FirebaseFirestore firestore;
  ChatFirestoreDataSource(this.firestore);

  CollectionReference<Map<String, dynamic>> get _chats =>
      firestore.collection('chats').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (data, _) => data,
          );

  CollectionReference<Map<String, dynamic>> _mensagens(String chatId) =>
      _chats.doc(chatId).collection('mensagens').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (data, _) => data,
          );

  Future<ConversaModel> iniciarConversa({
    required String usuarioAtualId,
    required String vendedorId,
    required String anuncioId,
  }) async {
    try {
      final existing = await _chats
          .where('anuncioId', isEqualTo: anuncioId)
          .where('usuarios', arrayContainsAny: [usuarioAtualId, vendedorId])
          .get();

      // Nota: filtro por "mesmos dois usuários" + anuncioId: precisamos confirmar ambos.
      for (final d in existing.docs) {
        final data = d.data();
        final usuarios = List<String>.from(data['usuarios'] ?? const []);
        if (usuarios.contains(usuarioAtualId) && usuarios.contains(vendedorId)) {
          return ConversaModel.fromJson(data).copyWith(id: d.id);
        }
      }

      final conversa = ConversaModel(
        id: '',
        usuario1Id: usuarioAtualId,
        usuario2Id: vendedorId,
        anuncioId: anuncioId,
        mensagens: const [],
      );

      final doc = await _chats.add({
        ...conversa.toJson(),
        'usuarios': [usuarioAtualId, vendedorId], // campo auxiliar p/ query
      });

      return conversa.copyWith(id: doc.id);
    } catch (e) {
      throw AppException('Erro ao iniciar conversa: $e');
    }
  }

  Future<List<ConversaModel>> listarConversasDoUsuario(String usuarioId) async {
    try {
      final q = await _chats.where('usuarios', arrayContains: usuarioId).get();
      return q.docs
          .map((d) => ConversaModel.fromJson(d.data()).copyWith(id: d.id))
          .toList();
    } catch (e) {
      throw AppException('Erro ao listar conversas: $e');
    }
  }

  Future<MensagemModel> enviarMensagem(MensagemModel msg) async {
    try {
      final data = msg.toJson();
      await _mensagens(msg.conversaId).add(data);
      return msg;
    } catch (e) {
      throw AppException('Erro ao enviar mensagem: $e');
    }
  }

  Future<List<MensagemModel>> listarMensagens(String conversaId) async {
    try {
      final q = await _mensagens(conversaId)
          .orderBy('timestamp', descending: false)
          .get();
      return q.docs
          .map((d) => MensagemModel.fromJson(d.data()))
          .toList();
    } catch (e) {
      throw AppException('Erro ao listar mensagens: $e');
    }
  }
}
