// import 'package:fit_bowl_2/di.dart';
// import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_all_categorys_use_case.dart';
// import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_categorybyid_use_case.dart';
// import 'package:get/get.dart';
// import 'package:fit_bowl_2/domain/entities/category.dart';

// class CategoryController extends GetxController {
//   List<Category> allCategories = [];
//   String selectedCategory = 'all'; // Default to "All"

//   // Fetch all categories
//   Future<bool> getAllCategories() async {
//     final res = await GetAllCategoriesUseCase(sl())();
//     return res.fold(
//       (failure) => false,
//       (categories) {
//         allCategories = categories;

//         return true;
//       },
//     );
//   }

//   // Update the selected category
//   void updateSelectedCategory(String? categoryId) {
//     selectedCategory = categoryId ?? 'all';
//     update();
//   }

//   // Fetch a single category by ID
//   Future<Category?> getCategoryById(String categoryId) async {
//     final res = await GetCategoryByIdUseCase(sl())(categoryId);
//     return res.fold(
//       (failure) => null,
//       (category) => category,
//     );
//   }
// }

import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_all_categorys_use_case.dart';
import 'package:fit_bowl_2/domain/usecases/categoryusecase/get_categorybyid_use_case.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/category.dart';

class CategoryController extends GetxController {
  List<Category> allCategories = [];
  String selectedCategory = 'all'; // Default to "All"

  String errorMessage = ''; // For error handling

  @override
  void onInit() {
    super.onInit();
    // Fetch all categories when the controller is initialized
    fetchAllCategories();
  }

  // Fetch all categories
  Future<void> fetchAllCategories() async {
    final res = await GetAllCategoriesUseCase(sl())();
    res.fold(
      (failure) {
        // Handle error

        update(); // Notify listeners
      },
      (categories) {
        // Update the list of categories
        allCategories = categories;
        update(); // Notify listeners
      },
    );
  }

  // Update the selected category
  void updateSelectedCategory(String categoryId) {
    selectedCategory = categoryId;
    update(); // Notify listeners
  }

  // Fetch a single category by ID
  Future<Category?> getCategoryById(String categoryId) async {
    final res = await GetCategoryByIdUseCase(sl())(categoryId);
    return res.fold(
      (failure) {
        // Handle error

        update(); // Notify listeners
        return null;
      },
      (category) => category,
    );
  }
}
