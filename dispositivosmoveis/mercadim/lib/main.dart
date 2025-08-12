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
        title: Text("Usando Container"),
      ),
      body: _body(),
    );
  }
}

_body() {
  return Container(
  margin: EdgeInsets.only(top:16,left: 40, right: 20),
  padding: EdgeInsets.all(10),
  color: Colors.yellow,
  child: Text("Ola, mundo! Ola, mundo! Ola, mundo! Ola, mundo!",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    maxLines: 3,
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      ),
    ),
  );
}
