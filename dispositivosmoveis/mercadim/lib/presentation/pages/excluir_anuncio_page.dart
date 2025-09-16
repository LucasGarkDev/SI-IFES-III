import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/excluir_anuncio_viewmodel.dart';

class ExcluirAnuncioButton extends ConsumerWidget {
  final String anuncioId;
  const ExcluirAnuncioButton({super.key, required this.anuncioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final excluirUC = ref.read(excluirAnuncioProvider);
    final vm = ExcluirAnuncioViewModel(excluirUC);

    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Excluir anúncio'),
            content: const Text('Tem certeza que deseja excluir este anúncio?'),
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
        if (confirm == true) {
          final ok = await vm.submit(anuncioId);
          if (ok && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Anúncio excluído com sucesso!')),
            );
          }
        }
      },
    );
  }
}
