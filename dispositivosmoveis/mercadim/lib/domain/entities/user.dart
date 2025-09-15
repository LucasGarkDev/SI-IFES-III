class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  User copyWith({String? name, String? photoUrl}) => User(
        id: id,
        name: name ?? this.name,
        email: email,
        photoUrl: photoUrl ?? this.photoUrl,
      );
}