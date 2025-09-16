import '../../domain/entities/localizacao_usuario.dart';
import '../../domain/repositories/localizacao_repository.dart';
import '../datasources/localizacao_device_ds.dart';

class LocalizacaoRepositoryImpl implements LocalizacaoRepository {
  final LocalizacaoDeviceDataSource ds;
  LocalizacaoRepositoryImpl(this.ds);

  @override
  Future<LocalizacaoUsuario> detectarLocalizacao() async {
    final model = await ds.detectar();
    return model.toEntity();
  }
}
