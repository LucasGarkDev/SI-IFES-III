// lib/core/providers/usecase_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_local_ds.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/signup_user.dart';
import '../services/id_service.dart';

// 🔽 IMPORTE A IMPLEMENTAÇÃO CONCRETA DO DS DO FEED
import '../../data/datasources/anuncio_remote_data_source_mock.dart';
// Se em vez de mock você tiver uma implementação real, importe-a:
// import '../../data/datasources/anuncio_remote_data_source_impl.dart';

import '../../data/repositories/anuncio_repository_impl.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';

// ====== Serviços base ======
final _idServiceProvider = Provider((ref) => IdService());

// ====== Auth (UC01 - Criar Conta) ======
final _authLocalDSProvider =
    Provider((ref) => AuthLocalDataSource(ref.read(_idServiceProvider)));

final _authRepositoryProvider =
    Provider((ref) => AuthRepositoryImpl(ref.read(_authLocalDSProvider)));

final signUpUserProvider =
    Provider((ref) => SignUpUser(ref.read(_authRepositoryProvider)));


// ====== Feed (UC11 - Visualizar anúncios) ======
// ✅ AQUI TEM QUE SER A CLASSE CONCRETA:
final _anuncioRemoteDSProvider =
    Provider((ref) => AnuncioRemoteDataSourceMock());
// Se for a real: Provider((ref) => AnuncioRemoteDataSourceImpl());

final _anuncioRepositoryProvider =
    Provider((ref) => AnuncioRepositoryImpl(ref.read(_anuncioRemoteDSProvider)));

final getAnunciosUseCaseProvider =
    Provider((ref) => GetAnunciosUseCase(ref.read(_anuncioRepositoryProvider)));
