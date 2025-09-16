import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/feed_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart'; // 🔑 importa a tela de detalhes
// import '../../domain/entities/anuncio.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  @override
  void initState() {
    super.initState();
    ref.read(feedViewModelProvider.notifier).carregarAnuncios('Baixo Guandu');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mercadim')),
      body: switch (state) {
        FeedLoading() => const Center(child: CircularProgressIndicator()),
        FeedError(:final mensagem) => Center(child: Text(mensagem)),
        FeedSuccess(:final anuncios) => anuncios.isEmpty
            ? const Center(child: Text('Nenhum anúncio encontrado.'))
            : ListView.builder(
                itemCount: anuncios.length,
                itemBuilder: (context, index) {
                  final anuncio = anuncios[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetalhesAnuncioPage(anuncio: anuncio),
                        ),
                      );
                    },
                    child: AnuncioCard(anuncio: anuncio),
                  );
                },
              ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
