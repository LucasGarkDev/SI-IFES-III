import 'anuncio_remote_data_source.dart';
import '../models/anuncio_model.dart';
import 'package:mercadim/core/exceptions/app_exception.dart';

class AnuncioRemoteDataSourceMock implements AnuncioRemoteDataSource {
  final List<AnuncioModel> _storage = [];

  AnuncioRemoteDataSourceMock() {
    if (_storage.isEmpty) {
      _storage.add(
        AnuncioModel(
          id: 'seed_1',
          titulo: 'Notebook Dell i5',
          descricao: 'Ótimo para estudos e trabalho remoto.',
          preco: 2500.0,
          categoria: 'Eletrônicos',
          cidade: 'Baixo Guandu', // ⚠️ bate com o FeedPage
          bairro: 'Centro',
          dataCriacao: DateTime.now(),
          imagemPrincipalUrl: 'https://via.placeholder.com/300x200?text=Notebook',
          usuarioId: 'u_seed',
          destaque: false,
          imagens: [
            'https://via.placeholder.com/300x200?text=Notebook',
          ],
        ),
      );
    }
  }

  @override
  Future<List<AnuncioModel>> fetchAnunciosPorCidade(String cidade) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final results = _storage.where(
      (a) => a.cidade.toLowerCase() == cidade.toLowerCase(),
    );
    // se não achar nada, devolve todos mesmo assim
    return results.isNotEmpty ? results.toList() : _storage;
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
    _storage.removeWhere((a) => a.id == id);
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
      results = results.where(
        (a) => a.categoria.toLowerCase() == categoria.toLowerCase(),
      );
    }
    if (precoMin != null) {
      results = results.where((a) => a.preco >= precoMin);
    }
    if (precoMax != null) {
      results = results.where((a) => a.preco <= precoMax);
    }

    // por enquanto, sem filtro real de distância
    return results.toList();
  }
}
