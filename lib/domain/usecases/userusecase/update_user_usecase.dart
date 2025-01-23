import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class UpdateUserUsecase {
  final AuthenticationRepository _authenticationRepository;

  const UpdateUserUsecase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    required String adresse,
    required String gender,
    required DateTime birthDate,
  }) async =>
      await _authenticationRepository.updateUser(
          id: id,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          address: adresse,
          gender: gender,
          birthDate: birthDate);
}
