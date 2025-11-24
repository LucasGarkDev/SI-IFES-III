// lib/presentation/pages/edit_profile_page.dart
import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:image_picker/image_picker.dart';

import '../../core/providers/usecase_providers.dart';
import '../../core/services/image_upload_service.dart';
import '../viewmodels/edit_profile_viewmodel.dart';
import '../../domain/entities/user.dart';

// novos componentes
import '../widgets/mercadim_page.dart';
import '../widgets/app_input.dart';
import '../widgets/app_button.dart';
import '../widgets/mercadim_card.dart';

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

  GoogleMapController? _mapController;

  final _imageService = ImageUploadService();

  File? _novaFoto;
  String? _photoUrl;
  LatLng? _selectedPosition;

  /// Coloque sua chave real depois
  final googlePlace = GooglePlace("SUA_CHAVE_API_GOOGLE_AQUI");

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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Erro ao selecionar imagem: $e")));
    }
  }

  Future<void> _buscarLocal(String value) async {
    if (value.trim().isEmpty) return;

    try {
      final results = await googlePlace.autocomplete.get(
        value,
        language: "pt-BR",
      );

      if (results?.predictions == null || results!.predictions!.isEmpty) return;

      final placeId = results.predictions!.first.placeId!;
      final details = await googlePlace.details.get(placeId);

      if (details?.result?.geometry?.location == null) return;

      final location = details!.result!.geometry!.location!;
      final pos = LatLng(location.lat!, location.lng!);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(pos, 12),
      );

      if (kIsWeb) {
        setState(() {
          _selectedPosition = pos;
          _city.text = value;
        });
        return;
      }

      final placemarks = await geocoding.placemarkFromCoordinates(
        location.lat!,
        location.lng!,
      );

      final cityName =
          placemarks.first.locality ?? placemarks.first.subAdministrativeArea;

      setState(() {
        _selectedPosition = pos;
        _city.text = cityName ?? value;
      });
    } catch (e) {
      print("Erro no buscarLocal: $e");
    }
  }

  Future<void> _aoTocarMapa(LatLng pos) async {
    try {
      _mapController?.animateCamera(CameraUpdate.newLatLng(pos));

      if (!kIsWeb) {
        final placemarks = await geocoding.placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );

        final cityName =
            placemarks.first.locality ?? placemarks.first.subAdministrativeArea;

        setState(() {
          _selectedPosition = pos;
          _city.text = cityName ?? "";
        });
      } else {
        setState(() {
          _selectedPosition = pos;
          _city.text = "Local selecionado";
        });
      }
    } catch (e) {
      print("Erro ao clicar no mapa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateUC = ref.read(updateProfileUseCaseProvider);
    final vm = EditProfileViewModel(updateUC);

    return MercadimPage(
      title: "Editar Perfil",
      scrollable: true,
      child: AnimatedBuilder(
        animation: vm,
        builder: (context, _) {
          return Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==============================
                // FOTO DO PERFIL
                // ==============================
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                        backgroundImage: _novaFoto != null
                            ? FileImage(_novaFoto!)
                            : (_photoUrl != null && _photoUrl!.isNotEmpty)
                                ? NetworkImage(_photoUrl!)
                                : const AssetImage(
                                    "assets/images/user_placeholder.png",
                                  ) as ImageProvider,
                      ),

                      // Botão de editar foto
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _selecionarFoto,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ==============================
                // NOME
                // ==============================
                AppInput(
                  label: "Nome",
                  controller: _name,
                  validator: vm.validateName,
                ),
                const SizedBox(height: 16),

                // ==============================
                // CIDADE / LOCALIZAÇÃO
                // ==============================
                AppInput(
                  label: "Cidade",
                  controller: _city,
                  icon: const Icon(Icons.location_city),
                  type: TextInputType.text,
                  validator: (_) => null,
                  onChanged: _buscarLocal,
                ),
                const SizedBox(height: 20),

                // ==============================
                // MAPA
                // ==============================
                Text(
                  "Selecione a localização (opcional)",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),

                MercadimCard(
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 260,
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(-14.2350, -51.9253), // Brasil
                        zoom: 3.5,
                      ),
                      onMapCreated: (c) => setState(() => _mapController = c),
                      onTap: _aoTocarMapa,
                      markers: _selectedPosition == null
                          ? {}
                          : {
                              Marker(
                                markerId: const MarkerId("selected"),
                                position: _selectedPosition!,
                              )
                            },
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ==============================
                // ERRO GLOBAL
                // ==============================
                if (vm.state.error != null)
                  Text(
                    vm.state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 12),

                // ==============================
                // BOTÃO SALVAR
                // ==============================
                AppButton(
                  label: "Salvar Alterações",
                  icon: Icons.save_outlined,
                  loading: vm.state.loading,
                  onPressed: vm.state.loading
                      ? null
                      : () async {
                          if (!(_form.currentState?.validate() ?? false)) {
                            return;
                          }

                          String? fotoFinal = _photoUrl;

                          if (_novaFoto != null) {
                            final url = await _imageService.pickAndUploadImage(
                              widget.currentUser.id,
                            );
                            if (url != null) fotoFinal = url;
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
                                    Text("Perfil atualizado com sucesso!"),
                              ),
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
