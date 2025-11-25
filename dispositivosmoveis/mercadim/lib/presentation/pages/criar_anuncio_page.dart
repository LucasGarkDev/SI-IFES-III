import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/providers/usecase_providers.dart';
import '../../core/services/image_upload_service.dart';
import '../../core/services/geofire_service.dart';

import '../viewmodels/criar_anuncio_viewmodel.dart';
import '../../domain/entities/anuncio.dart';
import '../widgets/app_input.dart';

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
  bool _btnLoading = false;

  final _imageService = ImageUploadService();
  late final GeoFireService _geoService;

  @override
  void initState() {
    super.initState();
    _geoService = GeoFireService(FirebaseFirestore.instance);
  }

  Future<void> _selecionarImagem() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _imagemSelecionada = File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    }
  }

  Future<Position?> _obterLocalizacao() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Serviço de localização desativado.')),
        );
        return null;
      }

      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
        if (perm == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permissão negada.')),
          );
          return null;
        }
      }

      if (perm == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão negada permanentemente.')),
        );
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao obter localização: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final criarUC = ref.read(criarAnuncioProvider);
    final vm = CriarAnuncioViewModel(criarUC);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Anúncio"),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: vm,
        builder: (_, __) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  // ===========================
                  // CAMPOS DE TEXTO
                  // ===========================
                  AppInput(
                    label: "Título",
                    controller: _titulo,
                    icon: const Icon(Icons.title),
                    validator: vm.validateTitulo,
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: "Descrição",
                    controller: _descricao,
                    icon: const Icon(Icons.description_outlined),
                    type: TextInputType.multiline,
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: "Preço (R\$)",
                    controller: _preco,
                    icon: const Icon(Icons.monetization_on_outlined),
                    type: const TextInputType.numberWithOptions(decimal: true),
                    validator: vm.validatePreco,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: "Categoria",
                    controller: _categoria,
                    icon: const Icon(Icons.category_outlined),
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: "Cidade",
                    controller: _cidade,
                    icon: const Icon(Icons.location_city),
                  ),
                  const SizedBox(height: 16),

                  AppInput(
                    label: "Bairro",
                    controller: _bairro,
                    icon: const Icon(Icons.place_outlined),
                  ),
                  const SizedBox(height: 24),

                  // ===========================
                  // IMAGEM DO ANÚNCIO
                  // ===========================
                  Text(
                    "Imagem principal",
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
                      child: _imagemSelecionada == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 42, color: Colors.green),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Selecionar imagem",
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _imagemSelecionada!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (vm.state.error != null)
                    Text(vm.state.error!, style: const TextStyle(color: Colors.red)),

                  // ===========================
                  // BOTÃO PUBLICAR
                  // ===========================
                  FilledButton(
                    onPressed: (vm.state.loading || _btnLoading)
                        ? null
                        : () async {
                            setState(() => _btnLoading = true);

                            if (!(_form.currentState?.validate() ?? false)) {
                              setState(() => _btnLoading = false);
                              return;
                            }

                            final precoValor =
                                double.tryParse(_preco.text.replaceAll(',', '.')) ?? 0.0;

                            // upload da imagem
                            String imageUrl = "";
                            if (_imagemSelecionada != null) {
                              final url = await _imageService.uploadFile(
                                _imagemSelecionada!,
                                widget.usuarioId,
                              );
                              if (url != null) imageUrl = url;
                            }

                            // localização
                            final pos = await _obterLocalizacao();
                            if (pos == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Não foi possível obter sua localização."),
                                ),
                              );
                              setState(() => _btnLoading = false);
                              return;
                            }

                            final anuncio = Anuncio(
                              id: "",
                              titulo: _titulo.text.trim(),
                              descricao: _descricao.text.trim(),
                              preco: precoValor,
                              categoria: _categoria.text.trim(),
                              cidade: _cidade.text.trim(),
                              bairro: _bairro.text.trim(),
                              dataCriacao: DateTime.now(),
                              imagemPrincipalUrl: imageUrl,
                              usuarioId: widget.usuarioId,
                              destaque: false,
                              imagens: [],
                            );

                            final created = await vm.submit(anuncio);

                            if (created != null && mounted) {
                              await _geoService.salvarLocalizacaoAnuncio(
                                anuncioId: created.id,
                                latitude: pos.latitude,
                                longitude: pos.longitude,
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Anúncio criado com sucesso!'),
                                ),
                              );

                              Navigator.pop(context, created);
                            }

                            setState(() => _btnLoading = false);
                          },
                    child: (vm.state.loading || _btnLoading)
                        ? const CircularProgressIndicator()
                        : const Text("Publicar"),
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
