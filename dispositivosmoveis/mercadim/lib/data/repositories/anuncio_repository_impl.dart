import 'package:mercadim/data/models/anuncio_model.dart';

import '../../core/services/id_service.dart';
import '../../domain/entities/anuncio.dart';
import '../../domain/repositories/anuncio_repository.dart';
import '../datasources/anuncio_remote_data_source.dart';
// import '../mappers/anuncio_mapper.dart';

class AnuncioRepositoryImpl implements AnuncioRepository {
  final AnuncioRemoteDataSource ds;
  final IdService _id;

  AnuncioRepositoryImpl(this.ds, this._id);

  @override
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade) async {
    final models = await ds.fetchAnunciosPorCidade(cidade);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Anuncio> criarAnuncio(Anuncio anuncio) async {
    final model = AnuncioModel.fromEntity(anuncio.copyWith(
      id: _id.make('ad_'),
      dataCriacao: DateTime.now(),
    ));
    final created = await ds.criarAnuncio(model);
    return created.toEntity();
  }

  @override
  Future<Anuncio> editarAnuncio(Anuncio anuncio) async {
    final model = AnuncioModel.fromEntity(anuncio);
    final updated = await ds.editarAnuncio(model);
    return updated.toEntity();
  }

  @override
  Future<void> excluirAnuncio(String id) async {
    await ds.excluirAnuncio(id);
  }

  @override
  Future<List<Anuncio>> buscarPorTitulo(String titulo) async {
    final models = await ds.buscarPorTitulo(titulo);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<Anuncio>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) async {
    final models = await ds.filtrar(
      categoria: categoria,
      precoMin: precoMin,
      precoMax: precoMax,
      distanciaKm: distanciaKm,
      userLat: userLat,
      userLng: userLng,
    );
    return models.map((e) => e.toEntity()).toList();
  }
}

