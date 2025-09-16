import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/anuncio.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/iniciar_conversa_viewmodel.dart';

class DetalhesAnuncioPage extends ConsumerWidget {
  final Anuncio anuncio;
  const DetalhesAnuncioPage({super.key, required this.anuncio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(anuncio.titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem principal
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                anuncio.imagemPrincipalUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Galeria de imagens extras
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
            Text(
              anuncio.titulo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'R\$ ${anuncio.preco.toStringAsFixed(2)}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.green),
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
            const SizedBox(height: 16),

            // Informações do vendedor (mock simples com usuarioId)
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 8),
                Text('Vendedor ID: ${anuncio.usuarioId}'),
              ],
            ),

            const SizedBox(height: 20),

            // Botão para iniciar conversa (UC20)
            FilledButton.icon(
              onPressed: () async {
                final iniciarConversaUC = ref.read(iniciarConversaProvider);
                final vm = IniciarConversaViewModel(iniciarConversaUC);

                final conversa = await vm.submit(
                  usuarioAtualId: 'u_atual', // 🔑 trocar pelo usuário logado
                  vendedorId: anuncio.usuarioId,
                  anuncioId: anuncio.id,
                );

                if (conversa != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Conversa iniciada com vendedor. ID: ${conversa.id}'),
                    ),
                  );
                  // Aqui você já pode navegar para a tela de chat (UC21)
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (_) => ChatPage(conversa: conversa),
                  // ));
                }
              },
              icon: const Icon(Icons.chat),
              label: const Text('Conversar com Vendedor'),
            ),
          ],
        ),
      ),
    );
  }
}
