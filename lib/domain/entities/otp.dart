class OTP {
  final String id;
  final String email;
  final String otp;
  final DateTime expiryDate;

  OTP({
    required this.id,
    required this.email,
    required this.otp,
    required this.expiryDate,
  });
}
