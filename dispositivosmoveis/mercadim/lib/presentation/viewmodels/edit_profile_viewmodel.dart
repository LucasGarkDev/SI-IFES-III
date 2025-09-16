import 'package:flutter/foundation.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/validators.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/update_profile.dart';

class EditProfileState {
  final bool loading;
  final String? error;
  final User? updated;

  const EditProfileState({this.loading = false, this.error, this.updated});

  EditProfileState copy({bool? loading, String? error, User? updated}) =>
      EditProfileState(
        loading: loading ?? this.loading,
        error: error,
        updated: updated,
      );
}

class EditProfileViewModel extends ChangeNotifier {
  final UpdateProfile _updateProfile;
  EditProfileState state = const EditProfileState();

  EditProfileViewModel(this._updateProfile);

  String? validateName(String? v) => Validators.required(v, field: 'Nome');

  Future<User?> submit(User user) async {
    state = state.copy(loading: true, error: null, updated: null);
    notifyListeners();
    try {
      final updated = await _updateProfile(user);
      state = state.copy(loading: false, updated: updated);
      notifyListeners();
      return updated;
    } on AppException catch (e) {
      state = state.copy(loading: false, error: e.mensagem);
      notifyListeners();
      return null;
    } catch (_) {
      state = state.copy(loading: false, error: 'Erro inesperado');
      notifyListeners();
      return null;
    }
  }
}
