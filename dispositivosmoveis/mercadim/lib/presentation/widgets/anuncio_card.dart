import 'package:flutter/material.dart';
import '../../domain/entities/anuncio.dart';

class AnuncioCard extends StatelessWidget {
  final Anuncio anuncio;

  const AnuncioCard({super.key, required this.anuncio});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            child: PageView(
              children: anuncio.imagens
                  .map((url) => Image.network(url, fit: BoxFit.cover))
                  .toList(),
            ),
          ),
          ListTile(
            title: Text(anuncio.titulo),
            subtitle: Text('R\$ ${anuncio.preco.toStringAsFixed(2)} • ${anuncio.bairro}'),
            trailing: anuncio.destaque ? const Icon(Icons.star, color: Colors.amber) : null,
          ),
        ],
      ),
    );
  }

}
