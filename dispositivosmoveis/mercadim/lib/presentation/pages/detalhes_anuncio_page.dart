import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/iniciar_conversa_viewmodel.dart';
import 'chat_page.dart';

// novos widgets
import '../widgets/mercadim_page.dart';
import '../widgets/mercadim_card.dart';
import '../widgets/app_button.dart';

class DetalhesAnuncioPage extends ConsumerWidget {
  final Anuncio anuncio;
  const DetalhesAnuncioPage({super.key, required this.anuncio});

  Future<Map<String, dynamic>?> _buscarVendedorInfo(WidgetRef ref) async {
    final repo = ref.read(userRepositoryProvider);
    try {
      final user = await repo.getById(anuncio.usuarioId);
      if (user != null) {
        return {
          'nome': user.name,
          'foto': user.photoUrl,
        };
      }
    } catch (_) {}
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authViewModelProvider);
    final usuarioAtual = auth.state.user;

    return MercadimPage(
      title: anuncio.titulo,
      scrollable: true,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _buscarVendedorInfo(ref),
        builder: (context, snapshot) {
          final vendedorNome = snapshot.data?['nome'] ?? 'Vendedor desconhecido';
          final vendedorFoto = snapshot.data?['foto'] ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======================================
              // 🖼 IMAGEM PRINCIPAL
              // ======================================
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    anuncio.imagemPrincipalUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset('assets/images/no_image.png'),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ======================================
              // 🖼 GALERIA
              // ======================================
              if (anuncio.imagens.isNotEmpty)
                SizedBox(
                  height: 105,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: anuncio.imagens.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, i) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        anuncio.imagens[i],
                        width: 110,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (anuncio.imagens.isNotEmpty) const SizedBox(height: 16),

              // ======================================
              // 📝 DETALHES DO ANÚNCIO
              // ======================================
              Text(
                anuncio.titulo,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),

              Text(
                'R\$ ${anuncio.preco.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),
              Text(
                anuncio.descricao,
                style: const TextStyle(fontSize: 15, height: 1.3),
              ),
              const SizedBox(height: 20),

              // ======================================
              // 📌 CATEGORIA / LOCALIZAÇÃO / DATA
              // ======================================
              MercadimCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.category, size: 20),
                        const SizedBox(width: 8),
                        Text(anuncio.categoria),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text('${anuncio.bairro}, ${anuncio.cidade}'),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Publicado em ${anuncio.dataCriacao.day}/${anuncio.dataCriacao.month}/${anuncio.dataCriacao.year}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ======================================
              // 👤 INFORMAÇÕES DO VENDEDOR
              // ======================================
              Text(
                "Vendedor",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),

              MercadimCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: vendedorFoto.isNotEmpty
                          ? NetworkImage(vendedorFoto)
                          : const AssetImage('assets/images/user_placeholder.png')
                              as ImageProvider,
                    ),
                    const SizedBox(width: 14),
                    Text(
                      vendedorNome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ======================================
              // 💬 BOTÃO DE CONVERSA
              // ======================================
              AppButton(
                label: "Conversar com o vendedor",
                icon: Icons.chat_bubble_outline,
                onPressed: () async {
                  if (usuarioAtual == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'É necessário estar logado para conversar.'),
                      ),
                    );
                    return;
                  }

                  final iniciarUC = ref.read(iniciarConversaProvider);
                  final vm = IniciarConversaViewModel(iniciarUC);

                  final conversa = await vm.submit(
                    usuarioAtualId: usuarioAtual.id,
                    vendedorId: anuncio.usuarioId,
                    anuncioId: anuncio.id,
                  );

                  if (conversa != null && context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          conversa: conversa,
                          usuarioAtualId: usuarioAtual.id,
                        ),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
