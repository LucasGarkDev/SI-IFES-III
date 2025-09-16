import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/localizacao_model.dart';

class LocalizacaoDeviceDataSource {
  Future<LocalizacaoModel> detectar() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const AppException('Serviço de localização desativado');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const AppException('Permissão de localização negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const AppException('Permissão de localização negada permanentemente');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String? cidade;
    String? bairro;
    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      cidade = placemarks.first.locality;
      bairro = placemarks.first.subLocality;
    }

    return LocalizacaoModel(
      latitude: position.latitude,
      longitude: position.longitude,
      cidade: cidade,
      bairro: bairro,
    );
  }
}
