import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/update_sale_usecase.dart';

abstract class SalesRepository {
  Future<Either<Failure, Sale>> createSale(CreateSaleParams params);
  Future<Either<Failure, List<Sale>>> getAllSales();
  Future<Either<Failure, Sale>> getSaleById(String saleId);
  Future<Either<Failure, Sale>> updateSale(UpdateSaleParams params);
  Future<Either<Failure, void>> deleteSale(String saleId);
}
