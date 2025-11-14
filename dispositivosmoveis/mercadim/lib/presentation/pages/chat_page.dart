import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../../domain/entities/conversa.dart';

class ChatPage extends ConsumerStatefulWidget {
  final Conversa conversa;
  final String usuarioAtualId;

  const ChatPage({
    super.key,
    required this.conversa,
    required this.usuarioAtualId,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final enviarUC = ref.read(enviarMensagemProvider);
    final vm = ChatViewModel(enviarUC);

    // ✅ Corrigido: identifica o outro usuário corretamente
    final outroUsuarioId = widget.conversa.usuario1Id == widget.usuarioAtualId
        ? widget.conversa.usuario2Id
        : widget.conversa.usuario1Id;

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: ref.read(userRepositoryProvider).getById(outroUsuarioId),
          builder: (context, snapshot) {
            final nome = snapshot.data?.name ?? 'Usuário';
            final foto = snapshot.data?.photoUrl ?? '';
            return Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: foto.isNotEmpty
                      ? NetworkImage(foto)
                      : const AssetImage('assets/images/user_placeholder.png')
                          as ImageProvider,
                ),
                const SizedBox(width: 8),
                Text(nome),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: vm,
              builder: (context, _) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: vm.state.mensagens.length,
                  itemBuilder: (context, i) {
                    final msg = vm.state.mensagens[i];
                    final isMine = msg.remetenteId == widget.usuarioAtualId;

                    return Align(
                      alignment:
                          isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin:
                            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.green.shade100
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(msg.conteudo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.green.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      vm.enviarTexto(
                        conversaId: widget.conversa.id,
                        usuarioId: widget.usuarioAtualId,
                        conteudo: text,
                      );
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
