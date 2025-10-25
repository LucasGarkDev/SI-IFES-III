import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/mensagem.dart';

class MensagemModel {
  final String id;
  final String conversaId;
  final String remetenteId;
  final TipoMensagem tipo;
  final String conteudo;
  final DateTime timestamp;

  const MensagemModel({
    required this.id,
    required this.conversaId,
    required this.remetenteId,
    required this.tipo,
    required this.conteudo,
    required this.timestamp,
  });

  // =====================================================
  // 🔁 Conversões entre Model e Entity
  // =====================================================

  Mensagem toEntity() => Mensagem(
        id: id,
        conversaId: conversaId,
        remetenteId: remetenteId,
        tipo: tipo,
        conteudo: conteudo,
        timestamp: timestamp,
      );

  factory MensagemModel.fromEntity(Mensagem m) => MensagemModel(
        id: m.id,
        conversaId: m.conversaId,
        remetenteId: m.remetenteId,
        tipo: m.tipo,
        conteudo: m.conteudo,
        timestamp: m.timestamp,
      );

  // =====================================================
  // 🔄 Conversões JSON / Firestore
  // =====================================================

  factory MensagemModel.fromJson(Map<String, dynamic> json) {
    return MensagemModel(
      id: json['id'] ?? '',
      conversaId: json['conversaId'] ?? '',
      remetenteId: json['remetenteId'] ?? '',
      tipo: _tipoFromString(json['tipo']),
      conteudo: json['conteudo'] ?? '',
      timestamp: (json['timestamp'] is Timestamp)
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.tryParse(json['timestamp']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'conversaId': conversaId,
        'remetenteId': remetenteId,
        'tipo': tipo.name,
        'conteudo': conteudo,
        'timestamp': Timestamp.fromDate(timestamp),
      };

  // =====================================================
  // 🧩 Utilitário copyWith
  // =====================================================

  MensagemModel copyWith({
    String? id,
    String? conversaId,
    String? remetenteId,
    TipoMensagem? tipo,
    String? conteudo,
    DateTime? timestamp,
  }) {
    return MensagemModel(
      id: id ?? this.id,
      conversaId: conversaId ?? this.conversaId,
      remetenteId: remetenteId ?? this.remetenteId,
      tipo: tipo ?? this.tipo,
      conteudo: conteudo ?? this.conteudo,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  // =====================================================
  // 🧠 Funções auxiliares
  // =====================================================

  static TipoMensagem _tipoFromString(dynamic value) {
    if (value is TipoMensagem) return value;
    final str = value?.toString().toLowerCase() ?? '';
    switch (str) {
      case 'imagem':
        return TipoMensagem.imagem;
      case 'localizacao':
        return TipoMensagem.localizacao;
      default:
        return TipoMensagem.texto;
    }
  }
}
