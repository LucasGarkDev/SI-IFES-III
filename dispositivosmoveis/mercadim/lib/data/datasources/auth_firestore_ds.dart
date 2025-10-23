import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/user_model.dart';

class AuthFirestoreDataSource {
  final FirebaseFirestore firestore;
  AuthFirestoreDataSource(this.firestore);

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('usuarios').withConverter<Map<String, dynamic>>(
            fromFirestore: (snap, _) => snap.data() ?? {},
            toFirestore: (data, _) => data,
          );

  Future<UserModel> createUser(UserModel user) async {
    try {
      final data = user.toJson();
      final doc = await _col.add(data);
      return user.copyWith(id: doc.id);
    } catch (e) {
      throw AppException('Erro ao criar usuário: $e');
    }
  }

  Future<UserModel?> findByEmail(String email) async {
    final q = await _col.where('email', isEqualTo: email).limit(1).get();
    if (q.docs.isEmpty) return null;
    return UserModel.fromJson(q.docs.first.data()).copyWith(id: q.docs.first.id);
  }

  Future<UserModel?> getById(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data()!).copyWith(id: doc.id);
  }

  Future<UserModel> updateProfile(UserModel updated) async {
    try {
      if (updated.id.isEmpty) {
        throw const AppException('ID do usuário ausente para atualização.');
      }
      await _col.doc(updated.id).update(updated.toJson());
      return updated;
    } catch (e) {
      throw AppException('Erro ao atualizar perfil: $e');
    }
  }

  /// Mock de visitante persistido (opcional).
  Future<UserModel> enterAsGuest() async {
    final guest = UserModel(
      id: '',
      name: 'Visitante',
      email: 'visitante@mercadim.com',
      city: null,
      photoUrl: null,
    );
    final created = await createUser(guest);
    return created;
  }
}
