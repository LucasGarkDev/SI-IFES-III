import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/pages/feed_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/favoritos_page.dart';
import 'presentation/pages/filtro_page.dart';
import 'presentation/pages/buscar_anuncios_page.dart';

void main() {
  runApp(const ProviderScope(child: MercadimApp()));
}

class MercadimApp extends StatelessWidget {
  const MercadimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercadim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      initialRoute: '/signup',
      routes: {
        '/signup': (_) => const SignUpPage(),
        '/feed': (_) => const FeedPage(),
        '/favoritos': (_) => const FavoritosPage(usuarioId: 'u_atual'),
        '/buscar': (_) => const BuscarAnunciosPage(),
        '/filtro': (_) => const FiltroPage(),
      },
    );
  }
}
