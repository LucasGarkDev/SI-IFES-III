import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageUploadService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  /// Abre a galeria e retorna o link de download da imagem enviada
  Future<String?> pickAndUploadImage(String usuarioId) async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked == null) return null;

      final file = File(picked.path);
      final fileName = path.basename(picked.path);
      final ref = _storage.ref().child('anuncios/$usuarioId/$fileName');

      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      return null;
    }
  }
}
