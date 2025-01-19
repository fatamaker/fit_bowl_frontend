import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/token.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class LoginUsecase {
  final AuthenticationRepository _authenticationRepository;

  const LoginUsecase(this._authenticationRepository);

  Future<Either<Failure, Token>> call(
          {required String email, required String password}) async =>
      await _authenticationRepository.login(email: email, password: password);
}
