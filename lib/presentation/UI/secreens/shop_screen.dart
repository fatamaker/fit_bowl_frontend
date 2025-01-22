// ignore_for_file: unused_local_variable

import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category fetching logic
                  GetBuilder<CategoryController>(
                    builder: (categoryController) {
                      return FutureBuilder(
                        future: categoryController.getAllCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (categoryController.allCategories.isEmpty) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                    child: Text('No categories available')),
                              );
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'LilitaOne',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryController
                                            .allCategories.length,
                                        itemBuilder: (_, index) {
                                          final category = categoryController
                                              .allCategories[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFADEBB3),
                                                border: Border.all(
                                                    color: Color(0xFFADEBB3),
                                                    width: 1.5),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: 50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(category.title),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text('Error: ${snapshot.error}')),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text('No categories available')),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Product fetching logic
          GetBuilder<ProductController>(
            builder: (productController) {
              return FutureBuilder(
                future: productController.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (productController.allProducts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: Text('No products available in ')),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            // Products Header
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10.0,
                              ),
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'LilitaOne',
                                ),
                              ),
                            ),
                            // Products Grid
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                ),
                                itemCount: productController.allProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final product =
                                      productController.allProducts[index];
                                  return InkWell(
                                    onTap: () {
                                      // Handle tap event and navigate to product details
                                    },
                                    child: ProductItem(product: product),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: Text('Error: ${snapshot.error}')),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child:
                            Center(child: CircularProgressIndicator.adaptive()),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(child: Text('No products available')),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
