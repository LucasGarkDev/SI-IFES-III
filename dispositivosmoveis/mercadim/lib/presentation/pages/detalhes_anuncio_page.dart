import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
// import '../../domain/entities/conversa.dart';
import '../viewmodels/iniciar_conversa_viewmodel.dart';
import 'chat_page.dart';

class DetalhesAnuncioPage extends ConsumerWidget {
  final Anuncio anuncio;
  const DetalhesAnuncioPage({super.key, required this.anuncio});

  Future<Map<String, dynamic>?> _buscarVendedorInfo(WidgetRef ref) async {
    final userRepo = ref.read(userRepositoryProvider);
    try {
      final user = await userRepo.getById(anuncio.usuarioId);
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

    return Scaffold(
      appBar: AppBar(title: Text(anuncio.titulo)),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _buscarVendedorInfo(ref),
        builder: (context, snapshot) {
          final vendedorNome = snapshot.data?['nome'] ?? 'Vendedor desconhecido';
          final vendedorFoto = snapshot.data?['foto'] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==== IMAGEM PRINCIPAL ====
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    anuncio.imagemPrincipalUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset('assets/images/no_image.png'),
                  ),
                ),
                const SizedBox(height: 12),

                // ==== GALERIA ====
                if (anuncio.imagens.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: anuncio.imagens.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          anuncio.imagens[i],
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // ==== DETALHES ====
                Text(
                  anuncio.titulo,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'R\$ ${anuncio.preco.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.green.shade700),
                ),
                const SizedBox(height: 8),
                Text(anuncio.descricao),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Icon(Icons.category, size: 20),
                    const SizedBox(width: 6),
                    Text(anuncio.categoria),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20),
                    const SizedBox(width: 6),
                    Text('${anuncio.bairro}, ${anuncio.cidade}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      'Publicado em ${anuncio.dataCriacao.day}/${anuncio.dataCriacao.month}/${anuncio.dataCriacao.year}',
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ==== INFORMAÇÕES DO VENDEDOR ====
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: vendedorFoto.isNotEmpty
                          ? NetworkImage(vendedorFoto)
                          : const AssetImage('assets/images/user_placeholder.png')
                              as ImageProvider,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      vendedorNome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ==== BOTÃO DE CONVERSA ====
                FilledButton.icon(
                  onPressed: () async {
                    if (usuarioAtual == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('É necessário estar logado para conversar.')),
                      );
                      return;
                    }

                    final iniciarConversaUC = ref.read(iniciarConversaProvider);
                    final vm = IniciarConversaViewModel(iniciarConversaUC);

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
                  icon: const Icon(Icons.chat),
                  label: const Text('Conversar com Vendedor'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
