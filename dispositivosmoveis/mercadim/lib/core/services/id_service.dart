import 'dart:math';

class IdService {
  final _r = Random();
  String make([String prefix = 'id_']) {
    final hex = List.generate(10, (_) => _r.nextInt(16))
        .map((e) => e.toRadixString(16))
        .join();
    return '$prefix$hex';
  }
}