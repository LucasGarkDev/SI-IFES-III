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

final formkey = GlobalKey<FormState>();
final controlador1 = TextEditingController();
final controlador2 = TextEditingController();

_body() {
  return Form(
    key: formkey,
    child: Container(
      margin: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextFormField(
            validator: (String? texto){
              if (texto == null || texto.isEmpty) {
                return "Campo obrigatório";
              }
              return null;
            },
            controller: controlador1,
          ),
          TextFormField(
            validator: (String? texto){
              if (texto == null || texto.isEmpty) {
                return "Campo obrigatório";
              }
              return null;
            },
            controller: controlador2,
          ),
          SizedBox(
            height: 16.0
          ),
          ElevatedButton(
            onPressed: (){
              if(formkey.currentState!.validate()) {
                print("O valor do campo 1 é: ${controlador1.text} e o valor do campo 2 é: ${controlador2.text}");
                
              }
            },
            child: Text("Imprime campos"),
          )
        ],
      )
    ),
  );
}
