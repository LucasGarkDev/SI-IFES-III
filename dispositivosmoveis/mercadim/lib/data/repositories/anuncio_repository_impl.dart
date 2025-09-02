import '../../domain/entities/anuncio.dart';
import '../../domain/repositories/anuncio_repository.dart';
import '../datasources/anuncio_remote_data_source.dart';
import '../mappers/anuncio_mapper.dart';

class AnuncioRepositoryImpl implements AnuncioRepository {
  final AnuncioRemoteDataSource remote;

  AnuncioRepositoryImpl(this.remote);

  @override
  Future<List<Anuncio>> obterAnunciosPorCidade(String cidade) async {
    final models = await remote.fetchAnunciosPorCidade(cidade);
    return models.map((e) => e.toEntity()).toList();
  }
}
