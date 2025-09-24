import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../../domain/entities/conversa.dart';
// import '../../domain/entities/mensagem.dart';

class ChatPage extends ConsumerStatefulWidget {
  final Conversa conversa;
  final String usuarioAtualId;

  const ChatPage({super.key, required this.conversa, required this.usuarioAtualId});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final enviarUC = ref.read(enviarMensagemProvider);
    final vm = ChatViewModel(enviarUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: vm,
              builder: (context, _) {
                return ListView.builder(
                  itemCount: vm.state.mensagens.length,
                  itemBuilder: (context, i) {
                    final msg = vm.state.mensagens[i];
                    final isMine = msg.remetenteId == widget.usuarioAtualId;
                    return Align(
                      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMine ? Colors.green[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(msg.conteudo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Digite uma mensagem...',
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
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
        ],
      ),
    );
  }
}
