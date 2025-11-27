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
import '../viewmodels/auth_viewmodel.dart';
import '../../domain/entities/user.dart';

// UI
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

  /// SUA API KEY REAL
  final googlePlace = GooglePlace("AIzaSyD_LvXUFnaatN7Gn3HZFniaQ9B5Dz0wdKU");

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.currentUser.name);
    _city = TextEditingController(text: widget.currentUser.city ?? '');
    _photoUrl = widget.currentUser.photoUrl;

    _centralizarMapaNaCidadeInicial();
  }

  /// ==============================================================
  /// 1️⃣ Centraliza automaticamente no mapa a cidade do perfil
  /// ==============================================================
  Future<void> _centralizarMapaNaCidadeInicial() async {
    final cidade = widget.currentUser.city;
    if (cidade == null || cidade.isEmpty) return;

    try {
      final results = await geocoding.locationFromAddress("$cidade, Brasil");
      if (results.isEmpty) return;

      final loc = results.first;
      final pos = LatLng(loc.latitude, loc.longitude);

      setState(() => _selectedPosition = pos);

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(pos, 12),
      );
    } catch (_) {}
  }

  /// ==============================================================
  /// 2️⃣ Selecionar foto de perfil
  /// ==============================================================
  Future<void> _selecionarFoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _novaFoto = File(picked.path);
      _photoUrl = null;
    });
  }

  /// ==============================================================
  /// 3️⃣ Buscar local digitado (autocomplete)
  /// ==============================================================
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

      final loc = details?.result?.geometry?.location;
      if (loc == null) return;

      final pos = LatLng(loc.lat!, loc.lng!);
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 12));

      final placemarks =
          await geocoding.placemarkFromCoordinates(loc.lat!, loc.lng!);

      final cidade =
          placemarks.first.locality ??
          placemarks.first.subAdministrativeArea ??
          placemarks.first.administrativeArea ??
          value;

      setState(() {
        _selectedPosition = pos;
        _city.text = cidade.toLowerCase();
      });
    } catch (_) {}
  }

  /// ==============================================================
  /// 4️⃣ Ao clicar no mapa → extrair cidade automaticamente
  /// ==============================================================
  Future<void> _aoTocarMapa(LatLng pos) async {
    try {
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 13));

      final placemarks =
          await geocoding.placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isEmpty) return;

      final cidade =
          placemarks.first.locality ??
          placemarks.first.subAdministrativeArea ??
          placemarks.first.administrativeArea ??
          "";

      if (cidade.isEmpty) return;

      setState(() {
        _selectedPosition = pos;
        _city.text = cidade.toLowerCase();
      });
    } catch (_) {}
  }

  /// ==============================================================
  /// 5️⃣ Salvar alterações e atualizar estado global do usuário
  /// ==============================================================
  Future<void> _salvarPerfil() async {
    if (!(_form.currentState?.validate() ?? false)) return;

    final updateUC = ref.read(updateProfileUseCaseProvider);
    final vm = EditProfileViewModel(updateUC);

    String? fotoFinal = _photoUrl;

    if (_novaFoto != null) {
      final url = await _imageService.uploadFile(
        _novaFoto!,
        widget.currentUser.id,
      );
      if (url != null) fotoFinal = url;
    }

    final updated = await vm.submit(
      widget.currentUser.copyWith(
        name: _name.text.trim(),
        city: _city.text.trim().toLowerCase(),
        photoUrl: fotoFinal,
      ),
    );

    if (updated == null) return;

    // ⭐ MUITO IMPORTANTE → Atualizar no estado global
    ref.read(authViewModelProvider).atualizarUsuario(updated);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Perfil atualizado com sucesso!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MercadimPage(
      title: "Editar Perfil",
      scrollable: true,
      child: Form(
        key: _form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _novaFoto != null
                        ? FileImage(_novaFoto!)
                        : (_photoUrl?.isNotEmpty ?? false)
                            ? NetworkImage(_photoUrl!)
                            : const AssetImage(
                                "assets/images/user_placeholder.png",
                              ) as ImageProvider,
                  ),
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

            // NOME
            AppInput(
              label: "Nome",
              controller: _name,
              validator: (_) =>
                  _name.text.trim().isEmpty ? "Nome obrigatório" : null,
            ),
            const SizedBox(height: 16),

            // CIDADE
            AppInput(
              label: "Cidade",
              controller: _city,
              icon: const Icon(Icons.location_city),
              onChanged: _buscarLocal,
            ),
            const SizedBox(height: 20),

            Text("Selecione a localização",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),

            // MAPA
            MercadimCard(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 260,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-14.2350, -51.9253),
                    zoom: 3.8,
                  ),
                  onMapCreated: (c) {
                    setState(() => _mapController = c);
                    _centralizarMapaNaCidadeInicial();
                  },
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

            // BOTÃO SALVAR
            AppButton(
              label: "Salvar Alterações",
              icon: Icons.save_outlined,
              onPressed: _salvarPerfil,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
