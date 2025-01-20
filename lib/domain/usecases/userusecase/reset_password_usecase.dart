import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class ResetPasswordUsecase {
  final AuthenticationRepository repository;

  const ResetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required String password}) async =>
      await repository.resetPassword(email: email, password: password);
}
