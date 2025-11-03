import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/feed_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';
import 'criar_anuncio_page.dart';
import '../../core/providers/usecase_providers.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // 🔹 Carrega inicialmente todos os anúncios (sem filtro de cidade)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedViewModelProvider.notifier).carregarAnuncios('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // 🔹 Usa debounce para evitar múltiplas requisições rápidas
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(feedViewModelProvider.notifier).carregarAnuncios(value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedViewModelProvider);
    final auth = ref.watch(authViewModelProvider);
    final usuario = auth.state.user;
    final isVisitante = usuario?.email == 'visitante@mercadim.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercadim'),
        actions: [
          if (usuario != null && !isVisitante)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.green.shade100,
                child: Icon(Icons.person,
                    color: Colors.green.shade900, size: 20),
              ),
            ),
        ],
      ),

      // ===============================
      // 🔍 Campo de busca por cidade
      // ===============================
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Filtrar por cidade...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.green.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ===============================
          // 📰 Lista de anúncios
          // ===============================
          Expanded(
            child: switch (state) {
              FeedLoading() =>
                  const Center(child: CircularProgressIndicator()),
              FeedError(:final mensagem) =>
                  Center(child: Text(mensagem, style: TextStyle(color: Colors.red))),
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
                                builder: (_) =>
                                    DetalhesAnuncioPage(anuncio: anuncio),
                              ),
                            );
                          },
                          child: AnuncioCard(anuncio: anuncio),
                        );
                      },
                    ),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),

      // ===============================
      // ➕ Botão flutuante de criação
      // ===============================
      floatingActionButton: (usuario != null && !isVisitante)
          ? FloatingActionButton.extended(
              onPressed: () async {
                final created = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CriarAnuncioPage(usuarioId: usuario.id),
                  ),
                );

                if (created != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Anúncio criado com sucesso!'),
                    ),
                  );

                  // 🔄 Recarrega a lista (mantendo o filtro atual)
                  ref
                      .read(feedViewModelProvider.notifier)
                      .carregarAnuncios(_searchController.text.trim());
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Anúncio'),
            )
          : null,
    );
  }
}
