import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class UpdateEmailUsercase {
  final AuthenticationRepository repository;

  UpdateEmailUsercase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String newEmail,
  }) {
    return repository.updateEmail(userId, newEmail);
  }
}
