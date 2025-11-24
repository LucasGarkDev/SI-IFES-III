import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import '../widgets/mercadim_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = ref.watch(authViewModelProvider);
    final state = authVM.state;

    return MercadimPage(
      title: "Login",
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================
            // ✏ CAMPOS
            // ============================
            AppInput(
              label: "E-mail",
              controller: _email,
              type: TextInputType.emailAddress,
              validator: (v) =>
                  v == null || v.isEmpty ? "Informe o e-mail" : null,
            ),
            const SizedBox(height: 16),

            AppInput(
              label: "Senha",
              controller: _pass,
              obscure: true,
              validator: (v) =>
                  v == null || v.length < 4 ? "Senha inválida" : null,
            ),

            const SizedBox(height: 20),

            // ============================
            // ❗ ERRO GLOBAL
            // ============================
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // ============================
            // 🟢 BOTÃO ENTRAR
            // ============================
            AppButton(
              label: "Entrar",
              loading: state.loading,
              onPressed: state.loading
                  ? null
                  : () async {
                      if (!(_form.currentState?.validate() ?? false)) return;

                      final user = await authVM.login(
                        _email.text.trim(),
                        _pass.text,
                      );

                      if (user != null && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Bem-vindo de volta, ${user.name}!"),
                          ),
                        );
                        Navigator.pushReplacementNamed(context, '/feed');
                      }
                    },
            ),

            const SizedBox(height: 16),

            // ============================
            // 🧾 BOTÃO "CRIAR CONTA"
            // ============================
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
