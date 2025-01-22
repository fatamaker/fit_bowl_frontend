import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/user.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class GetUserByIdUsecase {
  final AuthenticationRepository _authenticationRepository;

  const GetUserByIdUsecase(this._authenticationRepository);

  Future<Either<Failure, User>> call({required String userId}) async =>
      await _authenticationRepository.getUserById(userId: userId);
}
