import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../data/repositories/anuncio_repository_impl.dart';
import '../../data/datasources/anuncio_remote_data_source_mock.dart';

final getAnunciosUseCaseProvider = Provider<GetAnunciosUseCase>((ref) {
  final datasource = AnuncioRemoteDataSourceMock();
  final repository = AnuncioRepositoryImpl(datasource);
  return GetAnunciosUseCase(repository);
});
