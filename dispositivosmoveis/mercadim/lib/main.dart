import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mercadim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Componentes Visuais - Parte 2"),
      ),
      body: _body(),
    );
  }
}

final formkey = GlobalKey<FormState>();
final controlador1 = TextEditingController();
final controlador2 = TextEditingController();

_body() {
  return Stack(
    fit: StackFit.expand,
    children: <Widget>[
      Image.asset(
        "assets/imagem.jpg",
        fit: BoxFit.fill,
      ),
    ],
  );
}
