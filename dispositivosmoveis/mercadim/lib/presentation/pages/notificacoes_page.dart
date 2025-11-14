// lib/presentation/pages/notificacoes_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificacoesPage extends ConsumerStatefulWidget {
  final String usuarioId;
  const NotificacoesPage({super.key, required this.usuarioId});

  @override
  ConsumerState<NotificacoesPage> createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends ConsumerState<NotificacoesPage> {
  final List<Map<String, dynamic>> _notificacoes = [
    {
      'tipo': 'mensagem',
      'titulo': 'Nova mensagem recebida',
      'descricao': 'Você recebeu uma nova mensagem de João Silva.',
      'hora': '2 min atrás',
      'icone': Icons.chat_bubble_outline,
      'cor': Colors.green,
    },
    {
      'tipo': 'conversa',
      'titulo': 'Conversa iniciada',
      'descricao': 'Maria começou uma conversa sobre seu anúncio.',
      'hora': '10 min atrás',
      'icone': Icons.forum_outlined,
      'cor': Colors.blue,
    },
    {
      'tipo': 'sistema',
      'titulo': 'Atualização de segurança',
      'descricao': 'Seu perfil foi atualizado com sucesso.',
      'hora': 'Ontem',
      'icone': Icons.security_outlined,
      'cor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: _notificacoes.isEmpty
          ? const Center(
              child: Text('Nenhuma notificação no momento.'),
            )
          : ListView.separated(
              itemCount: _notificacoes.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final notif = _notificacoes[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: notif['cor'].withOpacity(0.2),
                    child: Icon(notif['icone'], color: notif['cor']),
                  ),
                  title: Text(
                    notif['titulo'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notif['descricao']),
                  trailing: Text(
                    notif['hora'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  onTap: () {
                    // 🔜 Futuramente: abrir conversa, anúncio ou tela específica
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Abrindo: ${notif['titulo']}')),
                    );
                  },
                );
              },
            ),
    );
  }
}
