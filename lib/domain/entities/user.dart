class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String email;
  final String? address;
  final String? phone;
  final String password;
  final String? gender;
  final DateTime? birthDate;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    required this.email,
    this.address,
    this.phone,
    required this.password,
    required this.gender,
    this.birthDate,
  });
}
