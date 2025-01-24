import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/supplement.dart';

abstract class SupplementRepository {
  Future<Either<Failure, Supplement>> getSupplementById(String id);
}
