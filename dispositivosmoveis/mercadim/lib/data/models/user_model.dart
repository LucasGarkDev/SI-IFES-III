import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  factory UserModel.fromEntity(User u) =>
      UserModel(id: u.id, name: u.name, email: u.email, photoUrl: u.photoUrl);

  User toEntity() => User(id: id, name: name, email: email, photoUrl: photoUrl);

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl};

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(
        id: j['id'] as String,
        name: j['name'] as String,
        email: j['email'] as String,
        photoUrl: j['photoUrl'] as String?,
      );
}