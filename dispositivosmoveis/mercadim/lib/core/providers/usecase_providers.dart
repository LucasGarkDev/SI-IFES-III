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
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/update_profile.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/criar_anuncio.dart';
import '../../domain/repositories/anuncio_repository.dart';
import '../../domain/usecases/editar_anuncio.dart';
import '../../domain/usecases/excluir_anuncio.dart';
import '../../domain/usecases/buscar_anuncios_por_titulo.dart';
import '../../domain/usecases/filtrar_anuncios.dart';
import '../../data/datasources/chat_local_ds.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/iniciar_conversa.dart';
import '../../domain/usecases/enviar_mensagem.dart';
import '../../data/datasources/favorito_local_ds.dart';
import '../../data/repositories/favorito_repository_impl.dart';
import '../../domain/usecases/toggle_favorito.dart';
import '../../domain/usecases/listar_favoritos.dart';
import '../../data/datasources/localizacao_device_ds.dart';
import '../../data/repositories/localizacao_repository_impl.dart';
import '../../domain/usecases/detectar_localizacao.dart';


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
    Provider((ref) => AnuncioRepositoryImpl(
          ref.read(_anuncioRemoteDSProvider),
          ref.read(_idServiceProvider),
        ));

final getAnunciosUseCaseProvider =
    Provider((ref) => GetAnunciosUseCase(ref.read(_anuncioRepositoryProvider)));

// ====== Auth (UC02 - Login) ======
final loginUserProvider =
    Provider((ref) => LoginUser(ref.read(_authRepositoryProvider)));

// ====== User (UC04 - Atualizar Perfil) ======
final _userRepositoryProvider =
    Provider((ref) => UserRepositoryImpl(ref.read(_authLocalDSProvider)));

final updateProfileProvider =
    Provider((ref) => UpdateProfile(ref.read(_userRepositoryProvider)));
    

final anuncioRepositoryProvider = Provider<AnuncioRepository>(
  (ref) => AnuncioRepositoryImpl(
    ref.read(_anuncioRemoteDSProvider),
    ref.read(_idServiceProvider),
  ),
);

final criarAnuncioProvider =
    Provider((ref) => CriarAnuncio(ref.read(anuncioRepositoryProvider)));

final editarAnuncioProvider =
    Provider((ref) => EditarAnuncio(ref.read(_anuncioRepositoryProvider)));

final excluirAnuncioProvider =
    Provider((ref) => ExcluirAnuncio(ref.read(_anuncioRepositoryProvider)));

final buscarAnunciosPorTituloProvider =
    Provider((ref) => BuscarAnunciosPorTitulo(ref.read(_anuncioRepositoryProvider)));

final filtrarAnunciosProvider =
    Provider((ref) => FiltrarAnuncios(ref.read(_anuncioRepositoryProvider)));

final _chatLocalDSProvider = Provider((ref) => ChatLocalDataSource());

final _chatRepositoryProvider =
    Provider((ref) => ChatRepositoryImpl(ref.read(_chatLocalDSProvider)));

final iniciarConversaProvider =
    Provider((ref) => IniciarConversa(ref.read(_chatRepositoryProvider)));

final enviarMensagemProvider =
    Provider((ref) => EnviarMensagem(ref.read(_chatRepositoryProvider)));

final _favoritoLocalDSProvider = Provider((ref) => FavoritoLocalDataSource());

final _favoritoRepositoryProvider =
    Provider((ref) => FavoritoRepositoryImpl(ref.read(_favoritoLocalDSProvider)));

final toggleFavoritoProvider =
    Provider((ref) => ToggleFavorito(ref.read(_favoritoRepositoryProvider)));

final listarFavoritosProvider = Provider(
  (ref) => ListarFavoritos(
    ref.read(_favoritoRepositoryProvider),
    ref.read(_anuncioRepositoryProvider),
  ),
);

// datasource
final _localizacaoDSProvider = Provider((ref) => LocalizacaoDeviceDataSource());

// repository
final _localizacaoRepositoryProvider =
    Provider((ref) => LocalizacaoRepositoryImpl(ref.read(_localizacaoDSProvider)));

// usecase
final detectarLocalizacaoProvider =
    Provider((ref) => DetectarLocalizacao(ref.read(_localizacaoRepositoryProvider)));
    