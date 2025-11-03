import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _imagemSelecionada;

  Future<void> _selecionarImagem() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        setState(() => _imagemSelecionada = File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    }
  }

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
                  // ======= CAMPOS PRINCIPAIS =======
                  TextFormField(
                    controller: _titulo,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: vm.validateTitulo,
                  ),
                  TextFormField(
                    controller: _descricao,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                  ),

                  // ✅ Campo preço com formato numérico
                  TextFormField(
                    controller: _preco,
                    decoration: const InputDecoration(labelText: 'Preço (R\$)'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
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

                  const SizedBox(height: 16),

                  // ✅ Seletor de imagem
                  Text(
                    'Imagem principal',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _selecionarImagem,
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: _imagemSelecionada != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _imagemSelecionada!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image_outlined,
                                      size: 40, color: Colors.green),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Selecionar imagem da galeria',
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ======= ERRO =======
                  if (vm.state.error != null)
                    Text(
                      vm.state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),

                  // ======= BOTÃO PUBLICAR =======
                  FilledButton(
                    onPressed: vm.state.loading
                        ? null
                        : () async {
                            if (!(_form.currentState?.validate() ?? false)) {
                              return;
                            }

                            final precoValor =
                                double.tryParse(_preco.text.replaceAll(',', '.')) ??
                                    0.0;

                            final anuncio = Anuncio(
                              id: '',
                              titulo: _titulo.text.trim(),
                              descricao: _descricao.text.trim(),
                              preco: precoValor,
                              categoria: _categoria.text.trim(),
                              cidade: _cidade.text.trim(),
                              bairro: _bairro.text.trim(),
                              dataCriacao: DateTime.now(),
                              imagemPrincipalUrl:
                                  _imagemSelecionada?.path ?? '', // ✅ caminho local
                              usuarioId: widget.usuarioId,
                              destaque: false,
                              imagens: [],
                            );

                            final created = await vm.submit(anuncio);

                            if (created != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Anúncio criado com sucesso!')),
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
