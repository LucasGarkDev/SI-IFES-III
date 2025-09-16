import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/usecase_providers.dart';
import '../viewmodels/localizacao_viewmodel.dart';

class LocalizacaoPage extends ConsumerWidget {
  const LocalizacaoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = LocalizacaoViewModel(ref.read(detectarLocalizacaoProvider));

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Localização')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          if (vm.state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.state.error != null) {
            return Center(child: Text(vm.state.error!));
          }
          if (vm.state.localizacao != null) {
            final loc = vm.state.localizacao!;
            return Center(
              child: Text(
                'Lat: ${loc.latitude}, Lng: ${loc.longitude}\n'
                'Cidade: ${loc.cidade ?? "-"}, Bairro: ${loc.bairro ?? "-"}',
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(
            child: FilledButton(
              onPressed: vm.detectar,
              child: const Text('Detectar Localização'),
            ),
          );
        },
      ),
    );
  }
}
