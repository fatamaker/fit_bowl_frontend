import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class CreateAccountUsecase {
  final AuthenticationRepository _authenticationRepository;

  const CreateAccountUsecase(this._authenticationRepository);

  Future<Either<Failure, String>> call(
          {required String firstName,
          required String lastName,
          required String imageUrl,
          required String email,
          required String adresse,
          required String phone,
          required String gender,
          required DateTime birthDate,
          required String password}) async =>
      await _authenticationRepository.createAccount(
          firstName: firstName,
          lastName: lastName,
          imageUrl: imageUrl,
          email: email,
          adresse: adresse,
          phone: phone,
          gender: gender,
          birthDate: birthDate,
          password: password);
}
