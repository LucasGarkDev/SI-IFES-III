// lib/presentation/pages/notificacoes_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/mercadim_page.dart';
import '../widgets/mercadim_card.dart';

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
    return MercadimPage(
      title: "Notificações",

      // Como a lista é longa, o MercadimPage usará scroll automático por padrão.
      child: _notificacoes.isEmpty
          ? const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  'Nenhuma notificação no momento.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          : Column(
              children: _notificacoes.map((notif) {
                return MercadimCard(
                  padding: const EdgeInsets.all(14),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Abrindo: ${notif['titulo']}'),
                        duration: const Duration(milliseconds: 900),
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ÍCONE 🔵🟢🟠
                      CircleAvatar(
                        radius: 22,
                        backgroundColor:
                            (notif['cor'] as Color).withOpacity(0.15),
                        child: Icon(
                          notif['icone'],
                          color: notif['cor'],
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Texto (Título + descrição)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notif['titulo'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notif['descricao'],
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Horário
                      Text(
                        notif['hora'],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
