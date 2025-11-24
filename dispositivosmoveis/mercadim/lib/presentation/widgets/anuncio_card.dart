// lib/presentation/widgets/anuncio_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/favorito_viewmodel.dart';
import '../pages/editar_anuncio_page.dart';
import '../viewmodels/feed_viewmodel.dart';
import '../viewmodels/excluir_anuncio_viewmodel.dart';
import 'mercadim_card.dart';

class AnuncioCard extends ConsumerWidget {
  final Anuncio anuncio;
  final VoidCallback? onTap;   // ⭐ ADICIONADO

  const AnuncioCard({
    super.key,
    required this.anuncio,
    this.onTap,               // ⭐ ADICIONADO
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authViewModelProvider);
    final usuario = auth.state.user;
    final isAutor = usuario != null && usuario.id == anuncio.usuarioId;

    return MercadimCard(
      padding: EdgeInsets.zero,
      onTap: onTap,   // ⭐ PASSANDO PARA O MERCADIMCARD

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========= IMAGEM PRINCIPAL =========
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: anuncio.imagemPrincipalUrl.isNotEmpty
                ? Image.network(
                    anuncio.imagemPrincipalUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 180,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/no_image.png',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    'assets/images/no_image.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          // ========= CABEÇALHO =========
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anuncio.titulo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'R\$ ${anuncio.preco.toStringAsFixed(2)} • ${anuncio.bairro}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    if (anuncio.destaque)
                      const Icon(Icons.star, color: Colors.amber),

                    if (isAutor) ...[
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.edit, size: 20, color: Colors.blueGrey),
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

                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.delete, size: 20, color: Colors.redAccent),
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
                                  content:
                                      Text('Erro ao excluir: ${vm.state.error!}'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),

          if (anuncio.descricao.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                anuncio.descricao,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              ),
            ),

          const Divider(height: 1),

          Consumer(
            builder: (context, ref, _) {
              final auth = ref.watch(authViewModelProvider);
              final usuario = auth.state.user;

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
                onPressed: usuario == null
                    ? null
                    : () async {
                        await vm.toggle(anuncio.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isFav
                                  ? 'Removido dos favoritos.'
                                  : 'Adicionado aos favoritos.',
                            ),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );

                        ref
                            .read(feedViewModelProvider.notifier)
                            .filtrar(apenasFavoritos: false, userId: usuario.id);
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
