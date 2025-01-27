import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';

class CreateSaleUseCase {
  final SalesRepository _repository;

  const CreateSaleUseCase(this._repository);

  Future<Either<Failure, Sale>> call(CreateSaleParams params) {
    return _repository.createSale(params);
  }
}

class CreateSaleParams {
  final String productId;
  final String userId;
  final int quantity;
  final List<String> supplements;
  final String size;

  CreateSaleParams({
    required this.productId,
    required this.userId,
    required this.quantity,
    this.supplements = const [],
    required this.size,
  });
}
