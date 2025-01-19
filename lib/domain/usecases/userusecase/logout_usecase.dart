import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class LogoutUsecase {
  final AuthenticationRepository repository;
  const LogoutUsecase(this.repository);
  Future<Either<Failure, Unit>> call() async => await repository.logout();
}
