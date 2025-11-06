import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/providers/usecase_providers.dart';
import '../../core/services/image_upload_service.dart';
import '../viewmodels/edit_profile_viewmodel.dart';
import '../../domain/entities/user.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final User currentUser;
  const EditProfilePage({super.key, required this.currentUser});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _form = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _city;

  File? _novaFoto;
  late String? _photoUrl;
  final _imageService = ImageUploadService();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.currentUser.name);
    _city = TextEditingController(text: widget.currentUser.city ?? '');
    _photoUrl = widget.currentUser.photoUrl;
  }

  Future<void> _selecionarFoto() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _novaFoto = File(picked.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateProfileUseCase = ref.read(updateProfileUseCaseProvider);
    final vm = EditProfileViewModel(updateProfileUseCase);

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: ListView(
                children: [
                  // ===== FOTO DE PERFIL =====
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.green.shade100,
                          backgroundImage: _novaFoto != null
                              ? FileImage(_novaFoto!)
                              : (_photoUrl != null && _photoUrl!.isNotEmpty)
                                  ? NetworkImage(_photoUrl!)
                                  : const AssetImage(
                                          'assets/images/user_placeholder.png')
                                      as ImageProvider,
                        ),
                        IconButton(
                          onPressed: _selecionarFoto,
                          icon: const Icon(Icons.camera_alt,
                              color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== CAMPOS DE TEXTO =====
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: vm.validateName,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _city,
                    decoration: const InputDecoration(labelText: 'Cidade'),
                  ),

                  const SizedBox(height: 20),

                  // ===== ERRO SE EXISTIR =====
                  if (vm.state.error != null)
                    Text(vm.state.error!,
                        style: const TextStyle(color: Colors.red)),

                  // ===== BOTÃO SALVAR =====
                  FilledButton(
                    onPressed: vm.state.loading
                        ? null
                        : () async {
                            if (!(_form.currentState?.validate() ?? false)) {
                              return;
                            }

                            // ✅ Upload da nova foto, se houver
                            String? fotoFinal = _photoUrl;
                            if (_novaFoto != null) {
                              final uploadedUrl = await _imageService
                                  .pickAndUploadImage(widget.currentUser.id);
                              if (uploadedUrl != null) {
                                fotoFinal = uploadedUrl;
                              }
                            }

                            final updated = await vm.submit(
                              widget.currentUser.copyWith(
                                name: _name.text.trim(),
                                city: _city.text.trim().isEmpty
                                    ? null
                                    : _city.text.trim(),
                                photoUrl: fotoFinal,
                              ),
                            );

                            if (updated != null && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Perfil atualizado com sucesso!')),
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
