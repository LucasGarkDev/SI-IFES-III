// lib/core/providers/usecase_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/auth_local_ds.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/signup_user.dart';
import '../services/id_service.dart';

// ====== Firestore ======
import '../../data/datasources/anuncio_firestore_ds.dart';
import '../../data/repositories/anuncio_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// ====== Auth ======
import '../../domain/usecases/login_user.dart';
// import '../../domain/usecases/update_profile.dart';
import '../../data/repositories/user_repository_impl.dart';

// ====== Domínio de Anúncios ======
import '../../domain/repositories/anuncio_repository.dart';
import '../../domain/usecases/get_anuncios_usecase.dart';
import '../../domain/usecases/criar_anuncio.dart';
import '../../domain/usecases/editar_anuncio.dart';
import '../../domain/usecases/excluir_anuncio.dart';
import '../../domain/usecases/buscar_anuncios_por_titulo.dart';
import '../../domain/usecases/filtrar_anuncios.dart';

// ====== Chat ======
import '../../data/datasources/chat_local_ds.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/iniciar_conversa.dart';
import '../../domain/usecases/enviar_mensagem.dart';

// ====== Favoritos ======
import '../../data/datasources/favorito_local_ds.dart';
import '../../data/repositories/favorito_repository_impl.dart';
import '../../domain/usecases/toggle_favorito.dart';
import '../../domain/usecases/listar_favoritos.dart';

// ====== Localização ======
import '../../data/datasources/localizacao_device_ds.dart';
import '../../data/repositories/localizacao_repository_impl.dart';
import '../../domain/usecases/detectar_localizacao.dart';

// ====== Auth extra ======
import '../../domain/usecases/entrar_como_visitante.dart';
import '../../presentation/viewmodels/auth_viewmodel.dart';
import '../../data/datasources/auth_firestore_ds.dart';
import '../../domain/usecases/update_profile.dart';

// ====== Serviços base ======
final _idServiceProvider = Provider((ref) => IdService());

// ====== Auth (UC01 - Criar Conta) ======
final _authLocalDSProvider =
    Provider((ref) => AuthLocalDataSource(ref.read(_idServiceProvider)));

final _authRepositoryProvider =
    Provider((ref) => AuthRepositoryImpl(ref.read(_authLocalDSProvider)));

// ====== Signup (UC01 - Criar Conta) ======
final signupUserUseCaseProvider = Provider(
  (ref) => SignupUser(ref.read(userRepositoryProvider)),
);

// ====== Update Profile (UC04 - Editar Perfil) ======
final updateProfileUseCaseProvider = Provider(
  (ref) => UpdateProfile(ref.read(userRepositoryProvider)),
);

// ====== Feed (UC11 - Visualizar anúncios) ======
final _anuncioRemoteDSProvider = Provider(
  (ref) => AnuncioRemoteDataSourceFirestore(FirebaseFirestore.instance),
);

final anuncioRepositoryProvider =
    Provider<AnuncioRepository>(
      (ref) => AnuncioRepositoryImpl(ref.read(_anuncioRemoteDSProvider)),
    );

final getAnunciosUseCaseProvider =
    Provider((ref) => GetAnunciosUseCase(ref.read(anuncioRepositoryProvider)));

// ====== Auth (UC02 - Login) ======
final loginUserProvider =
    Provider((ref) => LoginUser(ref.read(_authRepositoryProvider)));

// ====== User (UC04 - Atualizar Perfil) ======
final userRepositoryProvider = Provider(
  (ref) => UserRepositoryImpl(
    AuthFirestoreDataSource(FirebaseFirestore.instance),
  ),
);
// ====== CRUD Anúncio ======
final criarAnuncioProvider =
    Provider((ref) => CriarAnuncio(ref.read(anuncioRepositoryProvider)));

final editarAnuncioProvider =
    Provider((ref) => EditarAnuncio(ref.read(anuncioRepositoryProvider)));

final excluirAnuncioProvider =
    Provider((ref) => ExcluirAnuncio(ref.read(anuncioRepositoryProvider)));

// ====== Buscar e Filtrar Anúncios ======
final buscarAnunciosPorTituloProvider =
    Provider((ref) => BuscarAnunciosPorTitulo(ref.read(anuncioRepositoryProvider)));

final filtrarAnunciosProvider =
    Provider((ref) => FiltrarAnuncios(ref.read(anuncioRepositoryProvider)));

// ====== Chat ======
final _chatLocalDSProvider = Provider((ref) => ChatLocalDataSource());
final _chatRepositoryProvider =
    Provider((ref) => ChatRepositoryImpl(ref.read(_chatLocalDSProvider)));

final iniciarConversaProvider =
    Provider((ref) => IniciarConversa(ref.read(_chatRepositoryProvider)));

final enviarMensagemProvider =
    Provider((ref) => EnviarMensagem(ref.read(_chatRepositoryProvider)));

// ====== Favoritos ======
final _favoritoLocalDSProvider = Provider((ref) => FavoritoLocalDataSource());
final _favoritoRepositoryProvider =
    Provider((ref) => FavoritoRepositoryImpl(ref.read(_favoritoLocalDSProvider)));

final toggleFavoritoProvider =
    Provider((ref) => ToggleFavorito(ref.read(_favoritoRepositoryProvider)));

final listarFavoritosProvider = Provider(
  (ref) => ListarFavoritos(
    ref.read(_favoritoRepositoryProvider),
    ref.read(anuncioRepositoryProvider),
  ),
);

// ====== Localização ======
final _localizacaoDSProvider = Provider((ref) => LocalizacaoDeviceDataSource());
final _localizacaoRepositoryProvider =
    Provider((ref) => LocalizacaoRepositoryImpl(ref.read(_localizacaoDSProvider)));
final detectarLocalizacaoProvider =
    Provider((ref) => DetectarLocalizacao(ref.read(_localizacaoRepositoryProvider)));

// ====== Entrar como Visitante ======
final entrarComoVisitanteProvider =
    Provider((ref) => EntrarComoVisitante(ref.read(_authRepositoryProvider)));


// ====== Auth Global (ViewModel) ======
final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(
    ref.read(signupUserUseCaseProvider), // ✅ nome atualizado
    ref.read(entrarComoVisitanteProvider),
    ref.read(loginUserProvider),
  );
});
