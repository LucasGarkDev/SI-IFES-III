import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/signup_viewmodel.dart';
import '../viewmodels/visitante_viewmodel.dart';
import 'feed_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // casos de uso
    final signUpUseCase = ref.read(signUpUserProvider);
    final vm = SignUpViewModel(signUpUseCase);

    final visitanteUC = ref.read(entrarComoVisitanteProvider);
    final visitanteVM = VisitanteViewModel(visitanteUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: vm.validateName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    validator: vm.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pass,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: vm.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  if (vm.state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        vm.state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  FilledButton(
                    onPressed: vm.state.loading
                        ? null
                        : () async {
                            if (!(_form.currentState?.validate() ?? false)) {
                              return;
                            }
                            final user = await vm.submit(
                              name: _name.text.trim(),
                              email: _email.text.trim(),
                              password: _pass.text,
                            );
                            if (user != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Bem-vindo, ${user.name}!'),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FeedPage(),
                                ),
                              );
                            }
                          },
                    child: vm.state.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Criar conta'),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Ou continue sem criar conta',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.person_outline),
                    label: visitanteVM.state.loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Entrar como Visitante'),
                    onPressed: visitanteVM.state.loading
                        ? null
                        : () async {
                            final user = await visitanteVM.entrar();
                            if (user != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Entrou como Visitante'),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FeedPage(),
                                ),
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
