import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageDataSource {
  final storage = FirebaseStorage.instance;

  Future<String> uploadImagem(File file, String path) async {
    final ref = storage.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<String?> uploadFile(File file, String userId) async {
    try {
      final path = "anuncios/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final ref = FirebaseStorage.instance.ref().child(path);

      await ref.putFile(file);

      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
