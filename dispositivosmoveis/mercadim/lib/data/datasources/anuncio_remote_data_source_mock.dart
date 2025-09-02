import 'package:mercadim/core/exceptions/app_exception.dart';
import 'anuncio_remote_data_source.dart';
import '../models/anuncio_model.dart';

class AnuncioRemoteDataSourceMock implements AnuncioRemoteDataSource {
  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade) async {
    await Future.delayed(const Duration(seconds: 1)); // simula carregamento

    if (cidade == 'Inexistente') {
      throw AppException('Cidade sem suporte no momento.');
    }

    return [
      AnuncioModel(
        id: '1',
        titulo: 'Bicicleta Aro 29',
        descricao: 'Pouco usada, em ótimo estado.',
        preco: 850.0,
        categoria: 'Esportes',
        cidade: cidade,
        bairro: 'Centro',
        dataCriacao: DateTime.now(),
        imagemPrincipalUrl: 'https://via.placeholder.com/300x200',
        usuarioId: 'u1',
        destaque: true,
        imagens: [
          'https://via.placeholder.com/300x200',
          'https://via.placeholder.com/300x200?text=2',
        ],
      ),
      AnuncioModel(
        id: '2',
        titulo: 'Sofá Retrátil',
        descricao: 'Sofá 3 lugares, excelente estado.',
        preco: 1200.0,
        categoria: 'Móveis',
        cidade: cidade,
        bairro: 'Bela Vista',
        dataCriacao: DateTime.now().subtract(const Duration(hours: 5)),
        imagemPrincipalUrl: 'https://via.placeholder.com/300x200?text=Sofa',
        usuarioId: 'u2',
        destaque: false,
        imagens: [
          'https://via.placeholder.com/300x200?text=Sofa',
        ],
      ),
    ];
  }
}

