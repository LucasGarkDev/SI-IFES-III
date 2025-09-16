import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/buscar_anuncios_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';

class BuscarAnunciosPage extends ConsumerStatefulWidget {
  const BuscarAnunciosPage({super.key});

  @override
  ConsumerState<BuscarAnunciosPage> createState() => _BuscarAnunciosPageState();
}

class _BuscarAnunciosPageState extends ConsumerState<BuscarAnunciosPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buscarUC = ref.read(buscarAnunciosPorTituloProvider);
    final vm = BuscarAnunciosViewModel(buscarUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Buscar anúncios')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          final state = vm.state;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Buscar por título',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => vm.buscar(_controller.text),
                    ),
                  ),
                  onSubmitted: (v) => vm.buscar(v),
                ),
              ),
              Expanded(
                child: switch (state) {
                  BuscarIdle() => const Center(child: Text('Digite algo para buscar...')),
                  BuscarLoading() => const Center(child: CircularProgressIndicator()),
                  BuscarError(:final mensagem) => Center(child: Text(mensagem)),
                  BuscarSuccess(:final anuncios) => anuncios.isEmpty
                      ? const Center(child: Text('Nenhum anúncio encontrado.'))
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
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
