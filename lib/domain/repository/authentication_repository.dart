import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Unit>> createAccount(
      {required String firstName,
      required String lastName,
      required String imageUrl,
      required String email,
      required String adresse,
      required String phone,
      required String gender,
      required DateTime birthDate,
      required String password});

  Future<Either<Failure, Token>> login(
      {required String email, required String password});

  Future<Either<Failure, Token>> autologin();
  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> resetPassword(
      {required String email, required String password});
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email, required String destination});
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp});
}
