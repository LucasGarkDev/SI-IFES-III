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

    // Identifica o outro usuário
    final outroUsuarioId = widget.conversa.usuario1Id == widget.usuarioAtualId
        ? widget.conversa.usuario2Id
        : widget.conversa.usuario1Id;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
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
                const SizedBox(width: 10),
                Text(
                  nome,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          },
        ),
      ),

      body: Column(
        children: [
          // =============================
          // LISTA DE MENSAGENS
          // =============================
          Expanded(
            child: AnimatedBuilder(
              animation: vm,
              builder: (context, _) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  reverse: false,
                  itemCount: vm.state.mensagens.length,
                  itemBuilder: (context, i) {
                    final msg = vm.state.mensagens[i];
                    final isMine = msg.remetenteId == widget.usuarioAtualId;

                    return Align(
                      alignment: isMine
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isMine
                              ? Colors.green.shade200
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: isMine
                                ? const Radius.circular(12)
                                : const Radius.circular(0),
                            bottomRight: isMine
                                ? const Radius.circular(0)
                                : const Radius.circular(12),
                          ),
                        ),
                        child: Text(
                          msg.conteudo,
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // =============================
          // CAIXA DE DIGITAÇÃO
          // =============================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Digite uma mensagem...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.green.shade800,
                  iconSize: 28,
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
