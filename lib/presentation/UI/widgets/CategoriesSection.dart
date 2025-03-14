import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CategoriesSection extends StatelessWidget {
  final CategoryController categoryController;
  final ProductController productController;

  const CategoriesSection({
    super.key,
    required this.categoryController,
    required this.productController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        final categories = [
          {'id': 'all', 'title': 'all'},
          ...categoryController.allCategories.map((category) => {
                'id': category.id,
                'title': category.title,
              }),
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontFamily: 'LilitaOne'),
                ),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    final isSelected = categoryController.selectedCategory ==
                        category['title'];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          categoryController
                              .updateSelectedCategory(category['title']!);
                          productController.filterProducts(category['title']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.green
                                : const Color(0xFFADEBB3),
                            border: Border.all(
                              color: const Color(0xFFADEBB3),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Center(
                            child: Text(
                              category['title']!,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
