import 'package:fit_bowl_2/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.firstName,
    required super.lastName,
    super.imageUrl,
    required super.email,
    super.address,
    super.phone,
    required super.password,
    required super.gender,
    super.birthDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'] ?? 'N/A',
      lastName: json['lastName'] ?? 'N/A',
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? 'unknown@example.com',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? 'Not Specified',
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'])
          : null, // Handle null date
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName.isEmpty ? 'N/A' : firstName,
      'lastName': lastName.isEmpty ? 'N/A' : lastName,
      'imageUrl': imageUrl,
      'email': email.isEmpty ? 'unknown@example.com' : email,
      'address': address,
      'phone': phone,
      'password': password,
      'gender': gender!.isEmpty ? 'Not Specified' : gender,
      'birthDate': birthDate?.toIso8601String(),
    };
  }
}
