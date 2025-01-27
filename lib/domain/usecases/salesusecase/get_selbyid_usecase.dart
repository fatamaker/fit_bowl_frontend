import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';

class GetSaleByIdUseCase {
  final SalesRepository _repository;

  const GetSaleByIdUseCase(this._repository);

  Future<Either<Failure, Sale>> call(String saleId) {
    return _repository.getSaleById(saleId);
  }
}
