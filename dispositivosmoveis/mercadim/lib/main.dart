// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'presentation/pages/feed_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/favoritos_page.dart';
import 'presentation/pages/filtro_page.dart';
import 'presentation/pages/buscar_anuncios_page.dart';

// 👇 IMPORTANTE: importe o novo tema
import 'presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MercadimApp()));
}

class MercadimApp extends StatelessWidget {
  const MercadimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercadim',
      debugShowCheckedModeBanner: false,

      // 👇 AQUI A MÁGICA: usamos o tema completo do Mercadim
      theme: AppTheme.light,

      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/signup': (_) => const SignUpPage(),
        '/feed': (_) => const FeedPage(),
        '/favoritos': (_) => const FavoritosPage(usuarioId: 'u_atual'),
        '/buscar': (_) => const BuscarAnunciosPage(),
        '/filtro': (_) => const FiltroPage(),
      },
    );
  }
}
