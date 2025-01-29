import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';

import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';

import 'package:get/get.dart';

import '../../domain/usecases/salesusecase/get_selbyid_usecase.dart';

class SalesController extends GetxController {
  SalesController();

  bool isLoading = false;
  String errorMessage = '';
  Sale? sale;

  // Future<void> createSale(CreateSaleParams params) async {
  //   // Start loading
  //   isLoading = true;
  //   errorMessage = '';

  //   print(params);
  //   // Pass params to the use case and await result
  //   final result = await CreateSaleUseCase(sl())(params);
  //   print(result);
  //   result.fold(
  //     (failure) {
  //       errorMessage = 'Failed to crete sale';
  //     },
  //     (sale) {
  //       errorMessage = 'Sale created successfully!';
  //     },
  //   );

  Future<Sale?> createSale(CreateSaleParams params) async {
    print(params);
    // Pass params to the use case and await result
    final result = await CreateSaleUseCase(sl())(params);
    print(result);

    // Handle the result of the sale creation
    return result.fold(
      (failure) {
        errorMessage = 'Failed to create sale';
        return null; // Return null if there was an error
      },
      (sale) {
        errorMessage = 'Sale created successfully!';
        return sale; // Return the created sale model
      },
    );
  }

  Future<Sale?> getSaleById(String saleId) async {
    try {
      isLoading = true;
      errorMessage = '';
      update(); // Trigger UI update

      // Call the use case to fetch the sale
      final result = await GetSaleByIdUseCase(sl())(saleId: saleId);

      return result.fold(
        (failure) {
          isLoading = false;
          errorMessage = 'Failed to fetch sale. Please try again.';
          update(); // Trigger UI update
          return null; // Return null if fetching failed
        },
        (fetchedSale) {
          isLoading = false;
          sale = fetchedSale;
          update(); // Trigger UI update
          return fetchedSale; // Return the fetched Sale
        },
      );
    } catch (e) {
      isLoading = false;
      errorMessage = 'An unexpected error occurred. Please try again.';
      update(); // Trigger UI update
      return null; // Return null on exception
    }
  }
}
