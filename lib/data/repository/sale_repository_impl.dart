import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/sale_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/repository/sales_repository.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/update_sale_usecase.dart';

class SaleRepositoryImpl implements SalesRepository {
  final SaleRemoteDataSource saleRemoteDataSource;

  SaleRepositoryImpl({required this.saleRemoteDataSource});

  @override
  Future<Either<Failure, List<Sale>>> getAllSales() async {
    try {
      final sales = await saleRemoteDataSource.getAllSales();
      return Right(sales);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch sales."));
    }
  }

  @override
  Future<Either<Failure, Sale>> createSale(CreateSaleParams params) async {
    try {
      final sale = await saleRemoteDataSource.createSale(params);
      return Right(sale);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to create the sale."));
    }
  }

  @override
  Future<Either<Failure, Sale>> getSaleById(String id) async {
    try {
      final sale = await saleRemoteDataSource.getSaleById(id);
      return Right(sale);
    } on SaleNotFoundException {
      return Left(DataNotFoundFailure("Sale not found."));
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch the sale."));
    }
  }

  @override
  Future<Either<Failure, Sale>> updateSale(UpdateSaleParams params) async {
    try {
      final sale = await saleRemoteDataSource.updateSale(params);
      return Right(sale);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to update the sale."));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSale(String saleId) async {
    try {
      await saleRemoteDataSource.deleteSale(saleId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to delete the sale."));
    }
  }
}
