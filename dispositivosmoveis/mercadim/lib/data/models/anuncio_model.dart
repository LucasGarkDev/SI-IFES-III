// lib/data/models/anuncio_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/anuncio.dart';

class AnuncioModel {
  final String id;
  final String titulo;
  final String descricao;
  final double preco;
  final String categoria;
  final String cidade;
  final String bairro;
  final DateTime dataCriacao;
  final String imagemPrincipalUrl;
  final String usuarioId;
  final bool destaque;
  final List<String> imagens;

  // 🔥 Campos adicionados
  final double? latitude;
  final double? longitude;

  const AnuncioModel({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.categoria,
    required this.cidade,
    required this.bairro,
    required this.dataCriacao,
    required this.imagemPrincipalUrl,
    required this.usuarioId,
    required this.destaque,
    required this.imagens,
    this.latitude,
    this.longitude,
  });

  // =============================================================
  // ✅ JSON / MAP COMPATÍVEL COM FIRESTORE
  // =============================================================
  factory AnuncioModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return AnuncioModel.fromMap(json, id: id ?? '');
  }

  Map<String, dynamic> toJson() => toMap();

  factory AnuncioModel.fromMap(Map<String, dynamic> map, {required String id}) {
    final ts = map['dataCriacao'];
    late DateTime created;

    if (ts is Timestamp) {
      created = ts.toDate();
    } else if (ts is DateTime) {
      created = ts;
    } else if (ts is String) {
      created = DateTime.tryParse(ts) ?? DateTime.now();
    } else {
      created = DateTime.now();
    }

    return AnuncioModel(
      id: id,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      preco: (map['preco'] is num) ? (map['preco'] as num).toDouble() : 0.0,
      categoria: map['categoria'] ?? '',
      cidade: map['cidade'] ?? '',
      bairro: map['bairro'] ?? '',
      dataCriacao: created,
      imagemPrincipalUrl: map['imagemPrincipalUrl'] ?? '',
      usuarioId: map['usuarioId'] ?? '',
      destaque: map['destaque'] ?? false,
      imagens: (map['imagens'] as List?)?.map((e) => e.toString()).toList() ?? const [],

      // 🔥 LEITURA DA GEOLOCALIZAÇÃO
      latitude: (map['latitude'] is num) ? (map['latitude'] as num).toDouble() : null,
      longitude: (map['longitude'] is num) ? (map['longitude'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'preco': preco,
      'categoria': categoria,
      'cidade': cidade,
      'bairro': bairro,
      'dataCriacao': Timestamp.fromDate(dataCriacao),
      'imagemPrincipalUrl': imagemPrincipalUrl,
      'usuarioId': usuarioId,
      'destaque': destaque,
      'imagens': imagens,

      // 🔥 SALVAR GEOLOCALIZAÇÃO NO FIRESTORE
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // =============================================================
  // ✅ Conversão Entity ↔ Model
  // =============================================================
  factory AnuncioModel.fromEntity(Anuncio e) {
    return AnuncioModel(
      id: e.id,
      titulo: e.titulo,
      descricao: e.descricao,
      preco: e.preco,
      categoria: e.categoria,
      cidade: e.cidade,
      bairro: e.bairro,
      dataCriacao: e.dataCriacao,
      imagemPrincipalUrl: e.imagemPrincipalUrl,
      usuarioId: e.usuarioId,
      destaque: e.destaque,
      imagens: e.imagens,
      latitude: e.latitude,
      longitude: e.longitude,
    );
  }

  Anuncio toEntity() {
    return Anuncio(
      id: id,
      titulo: titulo,
      descricao: descricao,
      preco: preco,
      categoria: categoria,
      cidade: cidade,
      bairro: bairro,
      dataCriacao: dataCriacao,
      imagemPrincipalUrl: imagemPrincipalUrl,
      usuarioId: usuarioId,
      destaque: destaque,
      imagens: imagens,
      latitude: latitude,
      longitude: longitude,
    );
  }

  AnuncioModel copyWith({
    String? id,
    String? titulo,
    String? descricao,
    double? preco,
    String? categoria,
    String? cidade,
    String? bairro,
    DateTime? dataCriacao,
    String? imagemPrincipalUrl,
    String? usuarioId,
    bool? destaque,
    List<String>? imagens,
    double? latitude,
    double? longitude,
  }) {
    return AnuncioModel(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      categoria: categoria ?? this.categoria,
      cidade: cidade ?? this.cidade,
      bairro: bairro ?? this.bairro,
      dataCriacao: dataCriacao ?? this.dataCriacao,
      imagemPrincipalUrl: imagemPrincipalUrl ?? this.imagemPrincipalUrl,
      usuarioId: usuarioId ?? this.usuarioId,
      destaque: destaque ?? this.destaque,
      imagens: imagens ?? this.imagens,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
