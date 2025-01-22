import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class UpdatePasswordUsercase {
  final AuthenticationRepository _authenticationRepository;

  const UpdatePasswordUsercase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required String oldPassword,
    required String newPassword,
  }) async =>
      await _authenticationRepository.updatePassword(
          userId: userId, oldPassword: oldPassword, newPassword: newPassword);
}
