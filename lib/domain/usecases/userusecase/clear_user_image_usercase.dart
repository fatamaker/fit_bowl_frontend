import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class ClearUserImageUsecase {
  final AuthenticationRepository repository;
  ClearUserImageUsecase(this.repository);
  Future<Either<Failure, Unit>> call(String userId) async =>
      await repository.clearUserImage(userId);
}
