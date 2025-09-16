import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/criar_anuncio_viewmodel.dart';
import '../../domain/entities/anuncio.dart';

class CriarAnuncioPage extends ConsumerStatefulWidget {
  final String usuarioId;
  const CriarAnuncioPage({super.key, required this.usuarioId});

  @override
  ConsumerState<CriarAnuncioPage> createState() => _CriarAnuncioPageState();
}

class _CriarAnuncioPageState extends ConsumerState<CriarAnuncioPage> {
  final _form = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  final _preco = TextEditingController();
  final _categoria = TextEditingController();
  final _cidade = TextEditingController();
  final _bairro = TextEditingController();
  final _imagemPrincipal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final criarAnuncioUC = ref.read(criarAnuncioProvider);
    final vm = CriarAnuncioViewModel(criarAnuncioUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Novo Anúncio')),
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
                    controller: _titulo,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: vm.validateTitulo,
                  ),
                  TextFormField(
                    controller: _descricao,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),
                  TextFormField(
                    controller: _preco,
                    decoration: const InputDecoration(labelText: 'Preço'),
                    keyboardType: TextInputType.number,
                    validator: vm.validatePreco,
                  ),
                  TextFormField(
                    controller: _categoria,
                    decoration: const InputDecoration(labelText: 'Categoria'),
                  ),
                  TextFormField(
                    controller: _cidade,
                    decoration: const InputDecoration(labelText: 'Cidade'),
                  ),
                  TextFormField(
                    controller: _bairro,
                    decoration: const InputDecoration(labelText: 'Bairro'),
                  ),
                  TextFormField(
                    controller: _imagemPrincipal,
                    decoration:
                        const InputDecoration(labelText: 'URL da imagem principal'),
                  ),
                  const SizedBox(height: 20),
                  if (vm.state.error != null)
                    Text(vm.state.error!,
                        style: const TextStyle(color: Colors.red)),
                  FilledButton(
                    onPressed: vm.state.loading
                        ? null
                        : () async {
                            if (!(_form.currentState?.validate() ?? false)) {
                              return;
                            }
                            final anuncio = Anuncio(
                              id: '', // gerado no repo
                              titulo: _titulo.text.trim(),
                              descricao: _descricao.text.trim(),
                              preco: double.parse(_preco.text),
                              categoria: _categoria.text.trim(),
                              cidade: _cidade.text.trim(),
                              bairro: _bairro.text.trim(),
                              dataCriacao: DateTime.now(), // sobrescrito no repo
                              imagemPrincipalUrl: _imagemPrincipal.text.trim(),
                              usuarioId: widget.usuarioId,
                              destaque: false,
                              imagens: [],
                            );
                            final created = await vm.submit(anuncio);
                            if (created != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Anúncio criado com sucesso!')),
                              );
                              Navigator.pop(context, created);
                            }
                          },
                    child: vm.state.loading
                        ? const CircularProgressIndicator()
                        : const Text('Publicar'),
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
