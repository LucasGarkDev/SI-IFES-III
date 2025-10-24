// lib/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? city;
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.city,
    this.photoUrl,
  });

  factory UserModel.fromEntity(User u) => UserModel(
        id: u.id,
        name: u.name,
        email: u.email,
        city: u.city,
        photoUrl: u.photoUrl,
      );

  User toEntity() =>
      User(id: id, name: name, email: email, city: city, photoUrl: photoUrl);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'city': city,
        'photoUrl': photoUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        id: j['id'] ?? '',
        name: j['name'] ?? '',
        email: j['email'] ?? '',
        city: j['city'] as String?,
        photoUrl: j['photoUrl'] as String?,
      );

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? city,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
