// presentation/pages/signup_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/signup_viewmodel.dart';
import '../viewmodels/visitante_viewmodel.dart';
import 'feed_page.dart';

// 🔹 componentes padrões
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import '../widgets/mercadim_page.dart';

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
    final signupUC = ref.read(signupUserUseCaseProvider);
    final vm = SignUpViewModel(signupUC);

    final visitanteUC = ref.read(entrarComoVisitanteProvider);
    final visitanteVM = VisitanteViewModel(visitanteUC);

    return MercadimPage(
      title: "Criar Conta",
      child: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          return Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============================
                // 🔤 CAMPOS
                // ============================
                AppInput(
                  label: "Nome",
                  controller: _name,
                  validator: vm.validateName,
                ),
                const SizedBox(height: 16),

                AppInput(
                  label: "E-mail",
                  controller: _email,
                  validator: vm.validateEmail,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                AppInput(
                  label: "Senha",
                  controller: _pass,
                  obscure: true,
                  validator: vm.validatePassword,
                ),
                const SizedBox(height: 20),

                // ============================
                // ❗ ERRO GLOBAL
                // ============================
                if (vm.state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      vm.state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                // ============================
                // 🟢 BOTÃO "CRIAR CONTA"
                // ============================
                AppButton(
                  label: "Criar conta",
                  loading: vm.state.loading,
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
                                content: Text("Bem-vindo, ${user.name}!"),
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
                const SizedBox(height: 28),

                const Divider(),
                const SizedBox(height: 16),

                Center(
                  child: Text(
                    "Ou continue sem criar conta",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 16),

                // ============================
                // 👤 ENTRAR COMO VISITANTE
                // ============================
                AppButton(
                  icon: Icons.person_outline,
                  label: visitanteVM.state.loading
                      ? ""
                      : "Entrar como Visitante",
                  loading: visitanteVM.state.loading,
                  color: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.onSecondary,
                  onPressed: visitanteVM.state.loading
                      ? null
                      : () async {
                          final user = await visitanteVM.entrar();

                          if (user != null && mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Entrou como Visitante"),
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
          );
        },
      ),
    );
  }
}
