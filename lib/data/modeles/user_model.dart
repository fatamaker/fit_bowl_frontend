import '../../domain/entities/user.dart';

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
      firstName: json['firstName'],
      lastName: json['lastName'],
      imageUrl: json['imageUrl'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      password: json['password'],
      gender: json['gender'],
      birthDate: json['birthDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'email': email,
      'address': address,
      'phone': phone,
      'password': password,
      'gender': gender,
      'birthDate': birthDate.toString(),
    };
  }
}
