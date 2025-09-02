// lib/domain/entities/anuncio.dart

class Anuncio {
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

  const Anuncio({
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
}

