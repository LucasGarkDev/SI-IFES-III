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

  // 🔽 adiciona isso
  Anuncio copyWith({
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
    return Anuncio(
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
