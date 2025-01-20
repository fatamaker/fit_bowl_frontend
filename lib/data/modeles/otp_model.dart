import '../../domain/entities/otp.dart';

class OTPModel extends OTP {
  OTPModel({
    required super.id,
    required super.email,
    required super.otp,
    required super.expiryDate,
  });

  factory OTPModel.fromJson(Map<String, dynamic> json) {
    return OTPModel(
      id: json['_id'],
      email: json['email'],
      otp: json['otp'],
      expiryDate: DateTime.parse(json['expiry_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
      'expiry_date': expiryDate.toIso8601String(),
    };
  }
}
