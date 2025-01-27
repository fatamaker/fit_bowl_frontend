import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';

class UpdateSaleUseCase {
  final SalesRepository _repository;

  const UpdateSaleUseCase(this._repository);

  Future<Either<Failure, Sale>> call(UpdateSaleParams params) {
    return _repository.updateSale(params);
  }
}

class UpdateSaleParams {
  final String saleId;
  final String productId;
  final String userId;
  final int quantity;
  final List<String> supplements;
  final String size;

  UpdateSaleParams({
    required this.saleId,
    required this.productId,
    required this.userId,
    required this.quantity,
    this.supplements = const [],
    required this.size,
  });
}
