import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';

class DeleteSaleUseCase {
  final SalesRepository _repository;

  const DeleteSaleUseCase(this._repository);

  Future<Either<Failure, void>> call(String saleId) {
    return _repository.deleteSale(saleId);
  }
}
