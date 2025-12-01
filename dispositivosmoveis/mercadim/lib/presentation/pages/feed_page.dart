// lib/presentation/pages/feed_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/feed_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';
import 'criar_anuncio_page.dart';
import '../../core/providers/usecase_providers.dart';
import '../../presentation/pages/edit_profile_page.dart';
import 'notificacoes_page.dart';

// 🔹 componentes novos
import '../widgets/mercadim_page.dart';
import '../widgets/app_input.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final _tituloCtrl = TextEditingController();
  final _categoriaCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _precoMinCtrl = TextEditingController();
  final _precoMaxCtrl = TextEditingController();

  bool _mostrarFavoritos = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(feedViewModelProvider.notifier).carregarAnuncios(''),
    );
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _categoriaCtrl.dispose();
    _cidadeCtrl.dispose();
    _precoMinCtrl.dispose();
    _precoMaxCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _filtrar() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final auth = ref.read(authViewModelProvider);
      final user = auth.state.user;

      // 🔥 Recarrega sempre que o usuário for atualizado
      ref.listen(authViewModelProvider, (prev, next) {
        final cidadeNova = next.state.user?.city ?? '';
        ref.read(feedViewModelProvider.notifier).carregarAnuncios(cidadeNova);
      });

      final precoMin = double.tryParse(_precoMinCtrl.text.replaceAll(',', '.'));
      final precoMax = double.tryParse(_precoMaxCtrl.text.replaceAll(',', '.'));

      ref.read(feedViewModelProvider.notifier).filtrar(
            titulo: _tituloCtrl.text.trim(),
            categoria: _categoriaCtrl.text.trim(),
            precoMin: precoMin,
            precoMax: precoMax,
            apenasFavoritos: _mostrarFavoritos,
            userId: user?.id,
          );
    });
  }

  Future<void> _buscarAnunciosProximos() async {
    final vm = ref.read(feedViewModelProvider.notifier);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Buscando anúncios próximos...')),
    );

    await vm.carregarAnunciosProximos();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anúncios próximos carregados!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedViewModelProvider);
    final auth = ref.watch(authViewModelProvider);
    final usuario = auth.state.user;
    final isVisitante = usuario?.email == 'visitante@mercadim.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mercadim"),
        actions: [
          IconButton(
            tooltip: "Filtrar por cidade atual",
            icon: const Icon(Icons.location_on_outlined),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Obtendo cidade atual...")),
              );

              await ref.read(feedViewModelProvider.notifier).filtrarPorCidadeAtual();

              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Filtro por cidade aplicado!")),
              );
            },
          ),

          if (usuario != null && !isVisitante) ...[
            IconButton(
              icon: const Icon(Icons.notifications_none),
              tooltip: 'Notificações',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NotificacoesPage(usuarioId: usuario.id),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () async {
                  final updatedUser = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfilePage(currentUser: usuario),
                    ),
                  );

                  if (updatedUser != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Perfil atualizado com sucesso!'),
                      ),
                    );
                  }
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.green.shade100,
                  backgroundImage: (usuario.photoUrl != null &&
                          usuario.photoUrl!.isNotEmpty)
                      ? NetworkImage(usuario.photoUrl!)
                      : const AssetImage('assets/images/user_placeholder.png')
                          as ImageProvider,
                  child: (usuario.photoUrl == null ||
                          usuario.photoUrl!.isEmpty)
                      ? Icon(Icons.person,
                          color: Colors.green.shade900, size: 20)
                      : null,
                ),
              ),
            ),
          ],
        ],
      ),

      body: Column(
        children: [
          // ============================
          // 🔎 CAMPO DE BUSCA
          // ============================
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: TextField(
              controller: _tituloCtrl,
              onChanged: (_) => _filtrar(),
              decoration: InputDecoration(
                hintText: 'Buscar por título...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ============================
          // 🧩 FILTROS AVANÇADOS
          // ============================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ExpansionTile(
              title: const Text('Filtros avançados'),
              children: [
                AppInput(
                  label: "Categoria",
                  controller: _categoriaCtrl,
                  validator: (_) => null,
                  icon: const Icon(Icons.category_outlined),
                  type: TextInputType.text,
                ),
                const SizedBox(height: 8),

                AppInput(
                  label: "Cidade",
                  controller: _cidadeCtrl,
                  validator: (_) => null,
                  icon: const Icon(Icons.location_city_outlined),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        label: "Preço mín.",
                        controller: _precoMinCtrl,
                        validator: (_) => null,
                        type: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppInput(
                        label: "Preço máx.",
                        controller: _precoMaxCtrl,
                        validator: (_) => null,
                        type: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ],
                ),

                if (usuario != null && !isVisitante)
                  SwitchListTile(
                    title: const Text('Mostrar apenas favoritos ❤️'),
                    value: _mostrarFavoritos,
                    onChanged: (v) {
                      setState(() => _mostrarFavoritos = v);
                      _filtrar();
                    },
                  ),
              ],
            ),
          ),

          // ============================
          // 📋 LISTA DE ANÚNCIOS
          // ============================
          Expanded(
            child: switch (state) {
              FeedLoading() =>
                const Center(child: CircularProgressIndicator()),

              FeedError(:final mensagem) =>
                Center(
                  child: Text(
                    mensagem,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

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

      // ============================
      // ➕ BOTÃO FLUTUANTE (NOVO ANÚNCIO)
      // ============================
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

                  ref
                      .read(feedViewModelProvider.notifier)
                      .carregarAnuncios(_tituloCtrl.text.trim());
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Novo Anúncio'),
            )
          : null,
    );
  }
}
