import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/favorito_viewmodel.dart';
import '../pages/editar_anuncio_page.dart';
// ✅ importe o provider do feed
import '../viewmodels/feed_viewmodel.dart';

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

          // ========= TÍTULO / PREÇO =========
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

                // ✅ Botão editar — apenas se o usuário for o autor
                if (isAutor)
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
                        // 🔄 Recarregar o feed após edição
                        ref
                            .read(feedViewModelProvider.notifier)
                            .carregarAnuncios('');
                      }
                    },
                  ),
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
                onPressed: usuario == null
                    ? null
                    : () => vm.toggle(anuncio.id),
              );
            },
          ),
        ],
      ),
    );
  }
}
