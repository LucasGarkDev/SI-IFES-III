// lib/presentation/pages/feed_page.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/feed_viewmodel.dart';
import '../widgets/anuncio_card.dart';
import 'detalhes_anuncio_page.dart';
import 'criar_anuncio_page.dart';
import '../../core/providers/usecase_providers.dart';
import 'edit_profile_page.dart';
import 'notificacoes_page.dart';
import '../widgets/app_input.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  // Controladores
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

    // Carrega feed inicial com cidade do usuário
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(authViewModelProvider).state.user;
      final cidade = user?.city ?? '';
      ref.read(feedViewModelProvider.notifier).carregarAnuncios(cidade);
    });
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

  // ----------------------------------------------------------------------
  //          🔥 Listener Único — Atualiza feed quando usuário mudar
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    ref.listen(authViewModelProvider, (prev, next) {
      if (prev?.state.user?.city != next.state.user?.city) {
        final cidade = next.state.user?.city ?? '';
        ref.read(feedViewModelProvider.notifier).carregarAnuncios(cidade);
      }
    });

    final state = ref.watch(feedViewModelProvider);
    final auth = ref.watch(authViewModelProvider);
    final usuario = auth.state.user;
    final isVisitante = usuario?.email == 'visitante@mercadim.com';

    // ----------------------------------------------------------------------
    //                               UI
    // ----------------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mercadim"),
        actions: [
          // Filtro por cidade atual
          IconButton(
            icon: const Icon(Icons.location_on_outlined),
            tooltip: "Filtrar por cidade atual",
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Obtendo cidade atual...")),
              );

              await ref
                  .read(feedViewModelProvider.notifier)
                  .filtrarPorCidadeAtual();
            },
          ),

          if (!isVisitante && usuario != null) ...[
            IconButton(
              icon: const Icon(Icons.notifications_none),
              tooltip: "Notificações",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        NotificacoesPage(usuarioId: usuario.id),
                  ),
                );
              },
            ),

            GestureDetector(
              onTap: () async {
                final updatedUser = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfilePage(currentUser: usuario),
                  ),
                );

                if (updatedUser != null && mounted) {
                  // O ref.listen já irá recarregar o feed automaticamente
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Perfil atualizado com sucesso!"),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: (usuario.photoUrl != null &&
                          usuario.photoUrl!.isNotEmpty)
                      ? NetworkImage(usuario.photoUrl!)
                      : const AssetImage("assets/images/user_placeholder.png")
                          as ImageProvider,
                ),
              ),
            ),
          ],
        ],
      ),

      body: Column(
        children: [
          // ------------------------- CAMPO DE BUSCA -------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
            child: TextField(
              controller: _tituloCtrl,
              onChanged: (_) => _applyFiltersDebounced(),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar por título...',
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ------------------------- FILTROS AVANÇADOS -----------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ExpansionTile(
              title: const Text("Filtros avançados"),
              children: [
                AppInput(
                  label: "Categoria",
                  controller: _categoriaCtrl,
                  onChanged: (_) => _applyFiltersDebounced(),
                  icon: const Icon(Icons.category),
                ),
                AppInput(
                  label: "Cidade",
                  controller: _cidadeCtrl,
                  onChanged: (_) => _applyFiltersDebounced(),
                  icon: const Icon(Icons.location_city),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        label: "Preço mín.",
                        controller: _precoMinCtrl,
                        onChanged: (_) => _applyFiltersDebounced(),
                        type: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppInput(
                        label: "Preço máx.",
                        controller: _precoMaxCtrl,
                        onChanged: (_) => _applyFiltersDebounced(),
                        type: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                  ],
                ),
                if (!isVisitante)
                  SwitchListTile(
                    title: const Text("Mostrar apenas favoritos ❤️"),
                    value: _mostrarFavoritos,
                    onChanged: (v) {
                      setState(() => _mostrarFavoritos = v);
                      _applyFiltersDebounced();
                    },
                  ),
              ],
            ),
          ),

          // --------------------------- LISTA + REFRESH ------------------------
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshFeed,
              child: switch (state) {
                FeedLoading() =>
                  const Center(child: CircularProgressIndicator()),
                FeedError(:final mensagem) =>
                  Center(child: Text(mensagem)),
                FeedSuccess(:final anuncios) => anuncios.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(child: Text("Nenhum anúncio encontrado.")),
                        ],
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: anuncios.length,
                        itemBuilder: (_, i) {
                          final anuncio = anuncios[i];
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
          ),
        ],
      ),

      floatingActionButton: (!isVisitante && usuario != null)
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text("Novo Anúncio"),
              onPressed: () async {
                final created = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CriarAnuncioPage(usuarioId: usuario.id),
                  ),
                );

                if (created != null && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Anúncio criado com sucesso!"),
                    ),
                  );
                  await _refreshFeed();
                }
              },
            )
          : null,
    );
  }

  // ----------------------------------------------------------------------
  //                   FILTRO COM DEBOUNCE
  // ----------------------------------------------------------------------
  void _applyFiltersDebounced() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      final usuario = ref.read(authViewModelProvider).state.user;
      ref.read(feedViewModelProvider.notifier).filtrar(
            titulo: _tituloCtrl.text.trim(),
            categoria: _categoriaCtrl.text.trim(),
            cidade: _cidadeCtrl.text.trim(),
            precoMin:
                double.tryParse(_precoMinCtrl.text.replaceAll(',', '.')),
            precoMax:
                double.tryParse(_precoMaxCtrl.text.replaceAll(',', '.')),
            apenasFavoritos: _mostrarFavoritos,
            userId: usuario?.id,
          );
    });
  }

  // ----------------------------------------------------------------------
  //                    PULL TO REFRESH (RESET TOTAL)
  // ----------------------------------------------------------------------
  Future<void> _refreshFeed() async {
    _tituloCtrl.clear();
    _categoriaCtrl.clear();
    _cidadeCtrl.clear();
    _precoMinCtrl.clear();
    _precoMaxCtrl.clear();
    _mostrarFavoritos = false;

    final cidade = ref.read(authViewModelProvider).state.user?.city ?? '';
    await ref.read(feedViewModelProvider.notifier).carregarAnuncios(cidade);
  }
}
