class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? city;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.city,
  });

  User copyWith({
    String? name,
    String? photoUrl,
    String? city,
  }) =>
      User(
        id: id,
        name: name ?? this.name,
        email: email,
        photoUrl: photoUrl ?? this.photoUrl,
        city: city ?? this.city,
      );
}

