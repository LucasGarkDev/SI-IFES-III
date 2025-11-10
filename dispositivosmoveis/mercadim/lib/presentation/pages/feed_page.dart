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
// imports no topo
import 'notificacoes_page.dart';


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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedViewModelProvider.notifier).carregarAnuncios('');
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

  void _filtrar() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final auth = ref.read(authViewModelProvider);
      final user = auth.state.user;

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
          if (usuario != null && !isVisitante) ...[
            // 🔔 Ícone de notificações
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

            // 🧑‍💼 Avatar do perfil
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
                      const SnackBar(content: Text('Perfil atualizado com sucesso!')),
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
                  child: (usuario.photoUrl == null || usuario.photoUrl!.isEmpty)
                      ? Icon(Icons.person, color: Colors.green.shade900, size: 20)
                      : null,
                ),
              ),
            ),
          ],
        ],
      ),

      body: Column(
        children: [
          // 🔹 Campo de busca por título
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              controller: _tituloCtrl,
              onChanged: (_) => _filtrar(),
              decoration: InputDecoration(
                hintText: 'Buscar por título...',
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

          // 🔹 Filtros adicionais
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ExpansionTile(
              title: const Text('Filtros avançados'),
              children: [
                TextField(
                  controller: _categoriaCtrl,
                  onChanged: (_) => _filtrar(),
                  decoration: const InputDecoration(labelText: 'Categoria'),
                ),
                TextField(
                  controller: _cidadeCtrl,
                  onChanged: (_) => _filtrar(),
                  decoration: const InputDecoration(labelText: 'Cidade'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _precoMinCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                        decoration: const InputDecoration(labelText: 'Preço mín.'),
                        onChanged: (_) => _filtrar(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _precoMaxCtrl,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                        decoration: const InputDecoration(labelText: 'Preço máx.'),
                        onChanged: (_) => _filtrar(),
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
                      _filtrar(); // ✅ já chama o método correto com o novo estado
                    },
                  ),
              ],
            ),
          ),

          // 🔹 Lista de anúncios
          Expanded(
            child: switch (state) {
              FeedLoading() => const Center(child: CircularProgressIndicator()),
              FeedError(:final mensagem) =>
                  Center(child: Text(mensagem, style: const TextStyle(color: Colors.red))),
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
          ),
        ],
      ),

      // 🔹 Botão flutuante de criação
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
                    const SnackBar(content: Text('Anúncio criado com sucesso!')),
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
