import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/filtrar_anuncios_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';

class FiltroPage extends ConsumerStatefulWidget {
  const FiltroPage({super.key});

  @override
  ConsumerState<FiltroPage> createState() => _FiltroPageState();
}

class _FiltroPageState extends ConsumerState<FiltroPage> {
  final _categoria = TextEditingController();
  final _precoMin = TextEditingController();
  final _precoMax = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filtrarUC = ref.read(filtrarAnunciosProvider);
    final vm = FiltrarAnunciosViewModel(filtrarUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Filtrar anúncios')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          final state = vm.state;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _categoria,
                      decoration: const InputDecoration(labelText: 'Categoria'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _precoMin,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Preço mín'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _precoMax,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(labelText: 'Preço máx'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () {
                        vm.filtrar(
                          categoria: _categoria.text.isEmpty ? null : _categoria.text,
                          precoMin: _precoMin.text.isEmpty ? null : double.tryParse(_precoMin.text),
                          precoMax: _precoMax.text.isEmpty ? null : double.tryParse(_precoMax.text),
                        );
                      },
                      child: const Text('Aplicar Filtros'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: switch (state) {
                  FiltroIdle() => const Center(child: Text('Defina filtros para buscar')),
                  FiltroLoading() => const Center(child: CircularProgressIndicator()),
                  FiltroError(:final mensagem) => Center(child: Text(mensagem)),
                  FiltroSuccess(:final anuncios) => anuncios.isEmpty
                      ? const Center(child: Text('Nenhum resultado.'))
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
