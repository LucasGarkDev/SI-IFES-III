import 'package:mercadim/core/exceptions/app_exception.dart';
import 'anuncio_remote_data_source.dart';
import '../models/anuncio_model.dart';

/// Mock em memória para simular anúncios.
class AnuncioRemoteDataSourceMock implements AnuncioRemoteDataSource {
  final List<AnuncioModel> _storage = [];

  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade) async {
    await Future.delayed(const Duration(milliseconds: 200));

    // simula erro em cidade inválida
    if (cidade.toLowerCase() == 'inexistente') {
      throw const AppException('Cidade sem suporte no momento.');
    }

    final c = cidade.trim().toLowerCase();
    final filtrados = _storage
        .where((a) => a.cidade.trim().toLowerCase() == c)
        .toList();

    // se ainda não houver anúncios criados, retorna alguns mocks fixos
    if (filtrados.isEmpty) {
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

    return filtrados;
  }

  @override
  Future<AnuncioModel> criarAnuncio(AnuncioModel anuncio) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _storage.add(anuncio);
    return anuncio;
  }

  @override
  Future<AnuncioModel> editarAnuncio(AnuncioModel anuncio) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _storage.indexWhere((a) => a.id == anuncio.id);
    if (index == -1) {
      throw const AppException('Anúncio não encontrado');
    }
    _storage[index] = anuncio;
    return anuncio;
  }

  @override
  Future<void> excluirAnuncio(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _storage.indexWhere((a) => a.id == id);
    if (index == -1) {
      throw const AppException('Anúncio não encontrado');
    }
    _storage.removeAt(index);
  }
}
