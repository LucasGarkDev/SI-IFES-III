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

  // 🔽 conversor entidade → model
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
    );
  }

  // 🔽 conversor model → entidade
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
    );
  }
}
