import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/usecase_providers.dart';
import '../viewmodels/editar_anuncio_viewmodel.dart';
import '../../domain/entities/anuncio.dart';

class EditarAnuncioPage extends ConsumerStatefulWidget {
  final Anuncio anuncio;
  const EditarAnuncioPage({super.key, required this.anuncio});

  @override
  ConsumerState<EditarAnuncioPage> createState() => _EditarAnuncioPageState();
}

class _EditarAnuncioPageState extends ConsumerState<EditarAnuncioPage> {
  final _form = GlobalKey<FormState>();
  late TextEditingController _titulo;
  late TextEditingController _descricao;
  late TextEditingController _preco;
  late TextEditingController _categoria;
  late TextEditingController _cidade;
  late TextEditingController _bairro;
  late TextEditingController _imagemPrincipal;

  @override
  void initState() {
    super.initState();
    _titulo = TextEditingController(text: widget.anuncio.titulo);
    _descricao = TextEditingController(text: widget.anuncio.descricao);
    _preco = TextEditingController(text: widget.anuncio.preco.toString());
    _categoria = TextEditingController(text: widget.anuncio.categoria);
    _cidade = TextEditingController(text: widget.anuncio.cidade);
    _bairro = TextEditingController(text: widget.anuncio.bairro);
    _imagemPrincipal =
        TextEditingController(text: widget.anuncio.imagemPrincipalUrl);
  }

  @override
  Widget build(BuildContext context) {
    final editarAnuncioUC = ref.read(editarAnuncioProvider);
    final vm = EditarAnuncioViewModel(editarAnuncioUC);

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Anúncio')),
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
                            final updated = await vm.submit(
                              widget.anuncio.copyWith(
                                titulo: _titulo.text.trim(),
                                descricao: _descricao.text.trim(),
                                preco: double.parse(_preco.text),
                                categoria: _categoria.text.trim(),
                                cidade: _cidade.text.trim(),
                                bairro: _bairro.text.trim(),
                                imagemPrincipalUrl: _imagemPrincipal.text.trim(),
                              ),
                            );
                            if (updated != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Anúncio atualizado com sucesso!')),
                              );
                              Navigator.pop(context, updated);
                            }
                          },
                    child: vm.state.loading
                        ? const CircularProgressIndicator()
                        : const Text('Salvar Alterações'),
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
