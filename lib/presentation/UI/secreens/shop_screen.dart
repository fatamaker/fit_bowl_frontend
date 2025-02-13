import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/salade_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
import 'package:fit_bowl_2/presentation/controllers/cart_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find(); // Add CartController

  @override
  void initState() {
    categoryController.selectedCategory = 'all';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content scroll view
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Categories
                      GetBuilder<CategoryController>(
                        builder: (categoryController) {
                          return FutureBuilder(
                            future: categoryController.getAllCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (categoryController.allCategories.isEmpty) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Center(
                                        child: Text('No categories available')),
                                  );
                                } else {
                                  final List<Map<String, dynamic>> categories =
                                      [
                                    {'id': 'all', 'title': 'all'},
                                    ...categoryController.allCategories
                                        .map((category) => {
                                              'id': category.id,
                                              'title': category.title,
                                            }),
                                  ];

                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            'Categories',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'LilitaOne'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: AnimatedOpacity(
                                            opacity: snapshot.connectionState ==
                                                    ConnectionState.waiting
                                                ? 0.0
                                                : 1.0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: categories.length,
                                              itemBuilder: (_, index) {
                                                final category =
                                                    categories[index];
                                                final isSelected =
                                                    categoryController
                                                            .selectedCategory ==
                                                        category['title'];

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      categoryController
                                                          .updateSelectedCategory(
                                                              category[
                                                                  'title']);
                                                      productController
                                                          .filterProducts(
                                                              category[
                                                                  'title']);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: isSelected
                                                            ? Colors.green
                                                            : const Color(
                                                                0xFFADEBB3),
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xFFADEBB3),
                                                          width: 1.5,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      child: Center(
                                                        child: Text(
                                                          category['title'],
                                                          style: TextStyle(
                                                            color: isSelected
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                      child: Text('Error: ${snapshot.error}')),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Center(
                                      child:
                                          CircularProgressIndicator.adaptive()),
                                );
                              } else {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Center(
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
              // Products section
              GetBuilder<ProductController>(
                init: productController,
                builder: (productController) {
                  return FutureBuilder(
                    future: productController.getAllProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (productController.filteredProducts.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Center(
                                  child: Text('No products available')),
                            ),
                          );
                        } else {
                          return SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 6,
                              childAspectRatio: 0.75,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final product =
                                    productController.filteredProducts[index];
                                return AnimatedOpacity(
                                  opacity: snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? 0.0
                                      : 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              SaladeScreen(product: product),
                                        ),
                                      );
                                    },
                                    child: ProductItem(product: product),
                                  ),
                                );
                              },
                              childCount:
                                  productController.filteredProducts.length,
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:
                                Center(child: Text('Error: ${snapshot.error}')),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(
                                child: CircularProgressIndicator.adaptive()),
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(
                                child: Text('No products available')),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),

          Positioned(
            // bottom: 110,
            bottom: 8,
            right: 20, // Keep it aligned to the right
            child: GetBuilder<CartController>(
              builder: (cartController) {
                return AnimatedScale(
                  scale: cartController.cartSales.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: cartController.cartSales.isNotEmpty
                      ? badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -5, end: -5),
                          showBadge: cartController.cartSales.isNotEmpty,
                          badgeContent: Text(
                            cartController.cartSales.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red,
                            padding: const EdgeInsets.all(6),
                            borderRadius: BorderRadius.circular(8),
                            elevation: 2,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.shopping_cart),
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
