class Validators {
  static String? required(String? v, {String field = 'Campo'}) {
    if (v == null || v.trim().isEmpty) return '$field é obrigatório';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'E-mail é obrigatório';
    final ok = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim());
    if (!ok) return 'E-mail inválido';
    return null;
  }

  static String? minLen(String? v, int min, {String field = 'Campo'}) {
    if (v == null || v.trim().length < min) {
      return '$field deve ter pelo menos $min caracteres';
    }
    return null;
  }
}