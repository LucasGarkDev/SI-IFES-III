import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/listar_favoritos_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';

class FavoritosPage extends ConsumerStatefulWidget {
  final String usuarioId;
  const FavoritosPage({super.key, required this.usuarioId});

  @override
  ConsumerState<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends ConsumerState<FavoritosPage> {
  late final ListarFavoritosViewModel vm;

  @override
  void initState() {
    super.initState();
    final listarUC = ref.read(listarFavoritosProvider);
    vm = ListarFavoritosViewModel(listarUC);
    vm.carregar(widget.usuarioId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          final state = vm.state;
          return switch (state) {
            FavoritosIdle() => const SizedBox.shrink(),
            FavoritosLoading() => const Center(child: CircularProgressIndicator()),
            FavoritosError(:final mensagem) => Center(child: Text(mensagem)),
            FavoritosSuccess(:final anuncios) => anuncios.isEmpty
                ? const Center(child: Text('Nenhum favorito ainda.'))
                : ListView.builder(
                    itemCount: anuncios.length,
                    itemBuilder: (context, i) {
                      final anuncio = anuncios[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetalhesAnuncioPage(anuncio: anuncio),
                          ),
                        ),
                        child: AnuncioCard(anuncio: anuncio),
                      );
                    },
                  ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
