import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/salade_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final CategoryController controller = Get.put(CategoryController());

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<CategoryController>(
                  builder: (controller) {
                    return FutureBuilder(
                      future: controller.getAllCategories(),
                      builder: (context, snapshot) {
                        // Check if we have data first
                        if (snapshot.hasData) {
                          if (controller.allCategories.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text('No categories available')),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Text('Categories'),
                                  ),
                                  SizedBox(
                                    height: 60,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.allCategories.length,
                                      itemBuilder: (_, index) {
                                        final category =
                                            controller.allCategories[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue,
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
                        }

                        // Check for errors
                        else if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:
                                Center(child: Text('Error: ${snapshot.error}')),
                          );
                        }

                        // Check if still loading
                        else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                                child: CircularProgressIndicator.adaptive()),
                          );
                        }

                        // If no data, no error, and not loading
                        else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:
                                Center(child: Text('No categories available')),
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
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SaladeScreen(),
                      ),
                    );
                  },
                  child: ProductItem(
                    product: Product(
                      id: index.toString(), // Fixed type mismatch
                      name: 'Product ${index + 1}',
                      reference: 'reference_${index + 1}',
                      category: 'Food',
                      suppIds: ['Supplier1'], // Example supplier
                      sizes: {
                        'M': SizeInfo(price: 15.0, calories: 300),
                        'L': SizeInfo(price: 20.0, calories: 450),
                      }, // Example size info
                      image:
                          'assetes/Boulangerie_Grissol_Croutons_Spring_Mix_Salad_Recipe-removebg-preview.png',
                    ),
                  ),
                );
              },
              childCount: 10, // Replace with the number of products
            ),
          ),
        ),
      ]),
    );
  }
}
