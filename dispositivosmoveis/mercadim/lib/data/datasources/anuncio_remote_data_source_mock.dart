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

  @override
  Future<List<AnuncioModel>> buscarPorTitulo(String titulo) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final termo = titulo.trim().toLowerCase();
    return _storage
        .where((a) => a.titulo.toLowerCase().contains(termo))
        .toList();
  }

  @override
  Future<List<AnuncioModel>> filtrar({
    String? categoria,
    double? precoMin,
    double? precoMax,
    double? distanciaKm,
    double? userLat,
    double? userLng,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    Iterable<AnuncioModel> results = _storage;

    if (categoria != null && categoria.isNotEmpty) {
      results = results.where((a) =>
          a.categoria.toLowerCase() == categoria.toLowerCase());
    }

    if (precoMin != null) {
      results = results.where((a) => a.preco >= precoMin);
    }

    if (precoMax != null) {
      results = results.where((a) => a.preco <= precoMax);
    }

    // ⚠️ Distância é mockada por enquanto (sem lat/lng em AnuncioModel)
    if (distanciaKm != null && userLat != null && userLng != null) {
      // aqui entraria cálculo de haversine se tivéssemos coords
      // por enquanto, apenas retorna sem filtro
    }

    return results.toList();
  }
}
