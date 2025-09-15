import 'package:flutter/material.dart';
import 'presentation/pages/signup_page.dart';

void main() {
  runApp(const MercadimApp());
}

class MercadimApp extends StatelessWidget {
  const MercadimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercadim',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      routes: {
        '/': (_) => const SignUpPage(),
        // '/home': (_) => const HomePage(), // próximo passo do fluxo
      },
    );
  }
}