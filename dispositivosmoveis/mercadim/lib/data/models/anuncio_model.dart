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
  });

  // ====== mapeamentos ======
  factory AnuncioModel.fromMap(Map<String, dynamic> map, {required String id}) {
    final ts = map['dataCriacao'];
    DateTime created;
    if (ts is Timestamp) {
      created = ts.toDate();
    } else if (ts is String) {
      created = DateTime.tryParse(ts) ?? DateTime.now();
    } else if (ts is int) {
      created = DateTime.fromMillisecondsSinceEpoch(ts);
    } else {
      created = DateTime.now();
    }

    return AnuncioModel(
      id: id,
      titulo: map['titulo'] ?? '',
      descricao: map['descricao'] ?? '',
      preco: (map['preco'] is int)
          ? (map['preco'] as int).toDouble()
          : (map['preco'] as num?)?.toDouble() ?? 0.0,
      categoria: map['categoria'] ?? '',
      cidade: map['cidade'] ?? '',
      bairro: map['bairro'] ?? '',
      dataCriacao: created,
      imagemPrincipalUrl: map['imagemPrincipalUrl'] ?? '',
      usuarioId: map['usuarioId'] ?? '',
      destaque: map['destaque'] ?? false,
      imagens: (map['imagens'] as List?)?.map((e) => e.toString()).toList() ?? const [],
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
      // use timestamp do servidor quando criar; em update pode manter DateTime
      'dataCriacao': Timestamp.fromDate(dataCriacao),
      'imagemPrincipalUrl': imagemPrincipalUrl,
      'usuarioId': usuarioId,
      'destaque': destaque,
      'imagens': imagens,
    };
  }

  // ====== conversões domain <-> data ======
  factory AnuncioModel.fromEntity(Anuncio e) => AnuncioModel(
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
      );

  Anuncio toEntity() => Anuncio(
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
      );

  // ====== util ======
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
    );
  }
}
