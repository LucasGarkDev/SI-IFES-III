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

  AnuncioModel({
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

  factory AnuncioModel.fromMap(Map<String, dynamic> map) {
    return AnuncioModel(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      preco: (map['preco'] ?? 0).toDouble(),
      categoria: map['categoria'],
      cidade: map['cidade'],
      bairro: map['bairro'],
      dataCriacao: DateTime.parse(map['dataCriacao']),
      imagemPrincipalUrl: map['imagemPrincipalUrl'],
      usuarioId: map['usuarioId'],
      destaque: map['destaque'] ?? false,
      imagens: List<String>.from(map['imagens'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'preco': preco,
      'categoria': categoria,
      'cidade': cidade,
      'bairro': bairro,
      'dataCriacao': dataCriacao.toIso8601String(),
      'imagemPrincipalUrl': imagemPrincipalUrl,
      'usuarioId': usuarioId,
      'destaque': destaque,
      'imagens': imagens,
    };
  }
}
