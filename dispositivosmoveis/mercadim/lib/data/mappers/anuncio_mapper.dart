import '../../domain/entities/anuncio.dart';
import '../models/anuncio_model.dart';

extension AnuncioMapper on AnuncioModel {
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

  static AnuncioModel fromEntity(Anuncio entity) {
    return AnuncioModel(
      id: entity.id,
      titulo: entity.titulo,
      descricao: entity.descricao,
      preco: entity.preco,
      categoria: entity.categoria,
      cidade: entity.cidade,
      bairro: entity.bairro,
      dataCriacao: entity.dataCriacao,
      imagemPrincipalUrl: entity.imagemPrincipalUrl,
      usuarioId: entity.usuarioId,
      destaque: entity.destaque,
      imagens: entity.imagens,
    );
  }
}
