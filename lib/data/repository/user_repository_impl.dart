import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:fit_bowl_2/data/modeles/token_model.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this.authenticationLocalDataSource,
    this.authenticationRemoteDataSource,
  );

  @override
  Future<Either<Failure, Unit>> createAccount(
      {required String firstName,
      required String lastName,
      required String imageUrl,
      required String email,
      required String adresse,
      required String phone,
      required String gender,
      required DateTime birthDate,
      required String password}) async {
    try {
      await authenticationRemoteDataSource.createAccount(firstName, lastName,
          imageUrl, email, adresse, phone, gender, birthDate, password);
      return Right(unit);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Token>> login(
      {required String email, required String password}) async {
    try {
      TokenModel tm =
          await authenticationRemoteDataSource.login(email, password);
      await authenticationLocalDataSource.saveUserInformations(tm);
      Token t =
          Token(token: tm.token, expiryDate: tm.expiryDate, userId: tm.userId);

      return right(t);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> autologin() async {
    try {
      final tk = await authenticationRemoteDataSource.autoLogin();
      return right(tk);
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authenticationLocalDataSource.logout();
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
      {required String email, required String password}) async {
    try {
      await authenticationRemoteDataSource.resetPassword(email, password);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(
      {required String email, required int otp}) async {
    try {
      await authenticationRemoteDataSource.verifyOTP(email, otp);
      return const Right(unit);
    } on BadOTPException catch (e) {
      return Left(BadOTPFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(
      {required String email, required String destination}) async {
    try {
      await authenticationRemoteDataSource.forgetPassword(
          email: email, destination: destination);
      return const Right(unit);
    } on DataNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
