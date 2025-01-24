import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/supplement.dart';
import 'package:fit_bowl_2/domain/repository/supplement_repository.dart';

class GetSupplementByIdUseCase {
  final SupplementRepository _repository;

  const GetSupplementByIdUseCase(this._repository);

  Future<Either<Failure, Supplement>> call(String id) {
    return _repository.getSupplementById(id);
  }
}
