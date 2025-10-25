// lib/data/models/conversa_model.dart
import '../../domain/entities/conversa.dart';

class ConversaModel {
  final String id;
  final String usuario1Id;
  final String usuario2Id;
  final String anuncioId;
  final List<String> mensagens;

  const ConversaModel({
    required this.id,
    required this.usuario1Id,
    required this.usuario2Id,
    required this.anuncioId,
    required this.mensagens,
  });

  factory ConversaModel.fromJson(Map<String, dynamic> json) => ConversaModel(
        id: json['id'] ?? '',
        usuario1Id: json['usuario1Id'] ?? '',
        usuario2Id: json['usuario2Id'] ?? '',
        anuncioId: json['anuncioId'] ?? '',
        mensagens:
            (json['mensagens'] as List?)?.map((e) => e.toString()).toList() ??
                const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuario1Id': usuario1Id,
        'usuario2Id': usuario2Id,
        'anuncioId': anuncioId,
        'mensagens': mensagens,
      };

  Conversa toEntity() => Conversa(
        id: id,
        usuario1Id: usuario1Id,
        usuario2Id: usuario2Id,
        anuncioId: anuncioId,
        mensagens: mensagens,
      );

  factory ConversaModel.fromEntity(Conversa c) => ConversaModel(
        id: c.id,
        usuario1Id: c.usuario1Id,
        usuario2Id: c.usuario2Id,
        anuncioId: c.anuncioId,
        mensagens: c.mensagens,
      );

  ConversaModel copyWith({
    String? id,
    String? usuario1Id,
    String? usuario2Id,
    String? anuncioId,
    List<String>? mensagens,
  }) {
    return ConversaModel(
      id: id ?? this.id,
      usuario1Id: usuario1Id ?? this.usuario1Id,
      usuario2Id: usuario2Id ?? this.usuario2Id,
      anuncioId: anuncioId ?? this.anuncioId,
      mensagens: mensagens ?? this.mensagens,
    );
  }
}
