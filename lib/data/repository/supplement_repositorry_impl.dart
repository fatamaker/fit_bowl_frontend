import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/supplement_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/supplement.dart';
import 'package:fit_bowl_2/domain/repository/supplement_repository.dart';

class SupplementRepositoryImpl implements SupplementRepository {
  final SupplementRemoteDataSource supplementRemoteDataSource;

  SupplementRepositoryImpl({required this.supplementRemoteDataSource});

  @override
  Future<Either<Failure, Supplement>> getSupplementById(
      String supplementId) async {
    try {
      final supplement =
          await supplementRemoteDataSource.getSupplementById(supplementId);
      return Right(supplement);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch the supplement."));
    }
  }
}
