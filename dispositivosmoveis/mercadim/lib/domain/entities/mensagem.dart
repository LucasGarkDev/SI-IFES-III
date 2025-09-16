enum TipoMensagem { texto, imagem, localizacao }

class Mensagem {
  final String id;
  final String conversaId;
  final String remetenteId;
  final TipoMensagem tipo;
  final String conteudo;
  final DateTime timestamp;

  const Mensagem({
    required this.id,
    required this.conversaId,
    required this.remetenteId,
    required this.tipo,
    required this.conteudo,
    required this.timestamp,
  });
}
