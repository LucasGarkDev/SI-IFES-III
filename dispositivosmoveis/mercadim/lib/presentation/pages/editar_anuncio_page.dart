import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/providers/usecase_providers.dart';
import '../../core/services/image_upload_service.dart';
import '../viewmodels/editar_anuncio_viewmodel.dart';
import '../../domain/entities/anuncio.dart';

// novos widgets
import '../widgets/mercadim_page.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import '../widgets/mercadim_card.dart';

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
        SnackBar(content: Text("Erro ao selecionar imagem: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final editarAnuncioUC = ref.read(editarAnuncioProvider);
    final vm = EditarAnuncioViewModel(editarAnuncioUC);

    return MercadimPage(
      title: "Editar Anúncio",
      scrollable: true,
      child: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          return Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ===============================
                // ✏ CAMPOS DO ANÚNCIO
                // ===============================
                AppInput(
                  label: "Título",
                  controller: _titulo,
                  validator: vm.validateTitulo,
                ),
                const SizedBox(height: 14),

                AppInput(
                  label: "Descrição",
                  controller: _descricao,
                  maxLines: 3,
                ),
                const SizedBox(height: 14),

                AppInput(
                  label: "Preço (R\$)",
                  controller: _preco,
                  type: const TextInputType.numberWithOptions(decimal: true),
                  validator: vm.validatePreco,
                ),
                const SizedBox(height: 14),

                AppInput(
                  label: "Categoria",
                  controller: _categoria,
                ),
                const SizedBox(height: 14),

                AppInput(
                  label: "Cidade",
                  controller: _cidade,
                ),
                const SizedBox(height: 14),

                AppInput(
                  label: "Bairro",
                  controller: _bairro,
                ),
                const SizedBox(height: 20),

                // ===============================
                // 🖼 SEÇÃO DE IMAGENS
                // ===============================
                Text(
                  "Imagem principal",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),

                MercadimCard(
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 200,
                      color: Colors.grey.shade200,
                      child: _novaImagemSelecionada != null
                          ? Image.file(
                              _novaImagemSelecionada!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : (_imagemAtualUrl.isNotEmpty
                              ? Image.network(
                                  _imagemAtualUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) =>
                                      Image.asset("assets/images/no_image.png"),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined,
                                          size: 42,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Nenhuma imagem definida",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                AppButton(
                  icon: Icons.photo_camera_outlined,
                  label: "Selecionar nova imagem",
                  color: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.onSecondary,
                  onPressed: _selecionarNovaImagem,
                ),

                const SizedBox(height: 20),

                // ===============================
                // ❗ ERRO GLOBAL
                // ===============================
                if (vm.state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      vm.state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                // ===============================
                // 💾 BOTÃO SALVAR
                // ===============================
                AppButton(
                  label: "Salvar Alterações",
                  loading: vm.state.loading,
                  icon: Icons.save_outlined,
                  onPressed: vm.state.loading
                      ? null
                      : () async {
                          if (!(_form.currentState?.validate() ?? false)) {
                            return;
                          }

                          double precoValor =
                              double.tryParse(_preco.text.replaceAll(',', '.')) ??
                                  0.0;

                          String imagemFinal = _imagemAtualUrl;

                          if (_novaImagemSelecionada != null) {
                            final url =
                                await _imageService.pickAndUploadImage(
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
                                  content:
                                      Text("Anúncio atualizado com sucesso!")),
                            );
                            Navigator.pop(context, updated);
                          }
                        },
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
