import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class AutoLoginUsecase {
  final AuthenticationRepository repository;
  const AutoLoginUsecase(this.repository);
  Future<Either<Failure, Token>> call() async => await repository.autologin();
}
