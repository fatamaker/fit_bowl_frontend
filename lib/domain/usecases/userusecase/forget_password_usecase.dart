import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class ForgetPasswordUsecase {
  final AuthenticationRepository repository;

  const ForgetPasswordUsecase(this.repository);
  Future<Either<Failure, Unit>> call(
          {required String email, required String destination}) async =>
      await repository.forgetPassword(email: email, destination: destination);
}
