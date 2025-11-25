import '../../domain/entities/anuncio.dart';
import '../../domain/repositories/anuncio_repository.dart';
import '../datasources/anuncio_remote_data_source.dart';
import '../models/anuncio_model.dart';

class AnuncioRepositoryImpl implements AnuncioRepository {
  final AnuncioRemoteDataSource ds;

  AnuncioRepositoryImpl(this.ds);

  @override
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade) async {
    final models = await ds.fetchAnunciosPorCidade(cidade);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Anuncio> criarAnuncio(Anuncio anuncio) async {
    final created =
        await ds.criarAnuncio(AnuncioModel.fromEntity(anuncio));
    return created.toEntity();
  }

  @override
  Future<Anuncio> editarAnuncio(Anuncio anuncio) async {
    final edited =
        await ds.editarAnuncio(AnuncioModel.fromEntity(anuncio));
    return edited.toEntity();
  }

  @override
  Future<void> excluirAnuncio(String id) async {
    await ds.excluirAnuncio(id);
  }

  @override
  Future<List<Anuncio>> buscarPorTitulo(String titulo) async {
    final models = await ds.buscarPorTitulo(titulo);
    return models.map((m) => m.toEntity()).toList();
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
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Anuncio?> obterPorId(String id) async {
    final model = await ds.obterPorId(id);
    return model?.toEntity();
  }
}
