import '../../domain/entities/mensagem.dart';

class MensagemModel {
  final String id;
  final String conversaId;
  final String remetenteId;
  final TipoMensagem tipo;
  final String conteudo;
  final DateTime timestamp;

  MensagemModel({
    required this.id,
    required this.conversaId,
    required this.remetenteId,
    required this.tipo,
    required this.conteudo,
    required this.timestamp,
  });

  Mensagem toEntity() => Mensagem(
        id: id,
        conversaId: conversaId,
        remetenteId: remetenteId,
        tipo: tipo,
        conteudo: conteudo,
        timestamp: timestamp,
      );
}
