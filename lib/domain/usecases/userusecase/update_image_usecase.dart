import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/authentication_repository.dart';

class UpdateImageUsecase {
  final AuthenticationRepository _authenticationRepository;

  const UpdateImageUsecase(this._authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userId,
    required File image,
  }) async =>
      await _authenticationRepository.updateImage(userId: userId, image: image);
}
