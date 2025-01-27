import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class SalesController extends GetxController {
  final CreateSaleUseCase createSaleUseCase;

  SalesController(this.createSaleUseCase);

  bool isLoading = false;
  String errorMessage = '';

  Future<void> createSale(CreateSaleParams params) async {
    isLoading = true;
    errorMessage = '';
    update(); // Notify UI to rebuild

    final Either<Failure, Sale> result = await createSaleUseCase(params);

    result.fold(
      (failure) {
        errorMessage = _mapFailureToMessage(failure);
      },
      (sale) {
        // Handle successful creation (e.g., navigate or update UI)
        Get.snackbar('Success', 'Sale created successfully!');
      },
    );

    isLoading = false;
    update(); // Notify UI to rebuild
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error. Please try again.';
    }
    return 'Unexpected error occurred.';
  }
}
