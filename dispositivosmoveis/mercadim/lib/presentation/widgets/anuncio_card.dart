// lib/presentation/widgets/anuncio_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/favorito_viewmodel.dart';
import '../pages/editar_anuncio_page.dart';
import '../viewmodels/feed_viewmodel.dart';
import '../viewmodels/excluir_anuncio_viewmodel.dart';

class AnuncioCard extends ConsumerWidget {
  final Anuncio anuncio;

  const AnuncioCard({super.key, required this.anuncio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authViewModelProvider);
    final usuario = auth.state.user;
    final isAutor = usuario != null && usuario.id == anuncio.usuarioId;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========= IMAGEM PRINCIPAL =========
          if (anuncio.imagemPrincipalUrl.isNotEmpty)
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.network(
                anuncio.imagemPrincipalUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
            ),

          // ========= CABEÇALHO =========
          ListTile(
            title: Text(anuncio.titulo),
            subtitle: Text(
              'R\$ ${anuncio.preco.toStringAsFixed(2)} • ${anuncio.bairro}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (anuncio.destaque)
                  const Icon(Icons.star, color: Colors.amber),

                // ✅ Botões visíveis apenas se o usuário for o autor
                if (isAutor) ...[
                  // ✏️ Editar
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueGrey),
                    tooltip: 'Editar anúncio',
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditarAnuncioPage(anuncio: anuncio),
                        ),
                      );

                      if (updated != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Anúncio atualizado com sucesso!'),
                          ),
                        );
                        ref
                            .read(feedViewModelProvider.notifier)
                            .carregarAnuncios('');
                      }
                    },
                  ),

                  // 🗑️ Excluir
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    tooltip: 'Excluir anúncio',
                    onPressed: () async {
                      final confirmar = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Excluir anúncio'),
                          content: const Text(
                              'Tem certeza de que deseja excluir este anúncio?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancelar'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Excluir'),
                            ),
                          ],
                        ),
                      );

                      if (confirmar == true) {
                        final excluirUC = ref.read(excluirAnuncioProvider);
                        final vm = ExcluirAnuncioViewModel(excluirUC);
                        final ok = await vm.submit(anuncio.id);

                        if (ok && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Anúncio excluído com sucesso!')),
                          );
                          ref
                              .read(feedViewModelProvider.notifier)
                              .carregarAnuncios('');
                        } else if (vm.state.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Erro ao excluir: ${vm.state.error!}'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ],
            ),
          ),

          // ========= FAVORITAR =========
          Consumer(
            builder: (context, ref, _) {
              final vm = FavoritoViewModel(
                ref.read(toggleFavoritoProvider),
                usuario?.id ?? 'visitante',
              );
              final isFav = vm.isFavorito(anuncio.id);

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed:
                    usuario == null ? null : () => vm.toggle(anuncio.id),
              );
            },
          ),
        ],
      ),
    );
  }
}
