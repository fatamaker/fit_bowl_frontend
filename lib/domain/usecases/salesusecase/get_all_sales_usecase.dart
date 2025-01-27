import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';

class GetAllSalesUseCase {
  final SalesRepository _repository;

  const GetAllSalesUseCase(this._repository);

  Future<Either<Failure, List<Sale>>> call() {
    return _repository.getAllSales();
  }
}
