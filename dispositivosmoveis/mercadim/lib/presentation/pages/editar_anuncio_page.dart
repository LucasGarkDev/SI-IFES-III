import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/providers/usecase_providers.dart';
import '../../core/services/image_upload_service.dart'; // ✅ import do serviço
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

  File? _novaImagemSelecionada;
  late String _imagemAtualUrl;
  final _imageService = ImageUploadService();

  @override
  void initState() {
    super.initState();
    _titulo = TextEditingController(text: widget.anuncio.titulo);
    _descricao = TextEditingController(text: widget.anuncio.descricao);
    _preco = TextEditingController(text: widget.anuncio.preco.toString());
    _categoria = TextEditingController(text: widget.anuncio.categoria);
    _cidade = TextEditingController(text: widget.anuncio.cidade);
    _bairro = TextEditingController(text: widget.anuncio.bairro);
    _imagemAtualUrl = widget.anuncio.imagemPrincipalUrl;
  }

  Future<void> _selecionarNovaImagem() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _novaImagemSelecionada = File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    }
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

                  const SizedBox(height: 20),

                  // ========== IMAGEM ATUAL E NOVA ==========
                  Text(
                    'Imagem principal',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),

                  // ✅ Preview da imagem atual ou nova
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: _novaImagemSelecionada != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _novaImagemSelecionada!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )
                        : (_imagemAtualUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  _imagemAtualUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) => Image.asset(
                                    'assets/images/no_image.png',
                                    fit: BoxFit.cover,
                                  ),
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
                                      'Nenhuma imagem definida',
                                      style: TextStyle(
                                          color: Colors.green.shade700),
                                    ),
                                  ],
                                ),
                              )),
                  ),

                  const SizedBox(height: 8),

                  OutlinedButton.icon(
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Selecionar nova imagem'),
                    onPressed: _selecionarNovaImagem,
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

                            double precoValor =
                                double.tryParse(_preco.text.replaceAll(',', '.')) ??
                                    0.0;

                            // ✅ Upload da nova imagem (se houver)
                            String imagemFinal = _imagemAtualUrl;
                            if (_novaImagemSelecionada != null) {
                              final url = await _imageService.pickAndUploadImage(
                                widget.anuncio.usuarioId,
                              );
                              if (url != null) imagemFinal = url;
                            }

                            final updated = await vm.submit(
                              widget.anuncio.copyWith(
                                titulo: _titulo.text.trim(),
                                descricao: _descricao.text.trim(),
                                preco: precoValor,
                                categoria: _categoria.text.trim(),
                                cidade: _cidade.text.trim(),
                                bairro: _bairro.text.trim(),
                                imagemPrincipalUrl: imagemFinal,
                              ),
                            );

                            if (updated != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Anúncio atualizado com sucesso!')),
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
