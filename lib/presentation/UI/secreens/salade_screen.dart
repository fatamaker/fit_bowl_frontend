// import 'package:fit_bowl_2/data/modeles/supplement_model.dart';
// import 'package:fit_bowl_2/presentation/UI/widgets/buildAddOnOption.dart';
// import 'package:fit_bowl_2/presentation/controllers/supplement_contoller.dart';
// import 'package:flutter/material.dart';
// import 'package:fit_bowl_2/domain/entities/product.dart';
// import 'package:get/get.dart';

// class SaladeScreen extends StatefulWidget {
//   final Product product;

//   const SaladeScreen({super.key, required this.product});

//   @override
//   _SaladeScreenState createState() => _SaladeScreenState();
// }

// class _SaladeScreenState extends State<SaladeScreen> {
//   late SizeInfo selectedSize;
//   final List<bool> selectedAddOns = [false, false, false];
//   final Set<String> selectedSupplements = {};
//   SupplementModel? selectedSupplement; // Define selected supplement
//   int selectedQuantity = 1;

//   @override
//   void initState() {
//     super.initState();
//     selectedSize =
//         widget.product.sizes?.small ?? SizeInfo(price: 0, calories: 0);

//     Get.put(SupplementController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     final product = widget.product;
//     final Set<String> selectedSupplements = {};
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF3F6ED),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Info Section
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 60,
//                       backgroundImage: NetworkImage(product.image),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       product.name ?? "No name available",
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Taille: ${selectedSize == widget.product.sizes?.small ? 'S' : selectedSize == widget.product.sizes?.medium ? 'M' : 'L'}        '
//                       'calories: ${selectedSize.calories ?? 0}',
//                       style: const TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),

//             // Ingrédients Section
//             Center(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade50,
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Ingrédients',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       product.description != null
//                           ? product.description!
//                               .split(
//                                   '•') // Split the description into a list by commas
//                               .map((item) =>
//                                   '• ${item.trim()}') // Add a bullet to each item
//                               .join(
//                                   '\n') // Join items back with a newline character
//                           : "No ingredients available",
//                       style: const TextStyle(height: 1.5),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Center(
//               child: const Text(
//                 'Sizes:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Size Options
//             _buildSizeOptions(product.sizes),
//             const SizedBox(height: 60),

//             // Add-Ons Section
//             Center(
//               child: const Text(
//                 'Souhaitez-vous des suppléments :',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Supplement options
//             // ignore: avoid_print

//             ...product.suppId?.map(
//                   (supplement) => AddOnOption(
//                     suppId: supplement.id, // Access `id` of SupplementModel
//                     selectedSupplements: selectedSupplements,
//                     name: supplement.name, // Access other details as needed
//                     price: supplement.price,
//                     calories: supplement.calories,
//                   ),
//                 ) ??
//                 [],
//             const SizedBox(height: 30),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Combien de bol :',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.remove_circle_outline),
//                       onPressed: () {
//                         setState(() {
//                           if (selectedQuantity > 1) selectedQuantity--;
//                         });
//                       },
//                     ),
//                     Text('$selectedQuantity', style: TextStyle(fontSize: 18)),
//                     IconButton(
//                       icon: Icon(Icons.add_circle_outline),
//                       onPressed: () {
//                         setState(() {
//                           selectedQuantity++;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 100),

//             // Add to Cart Button
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 12.0, horizontal: 24.0),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8)),
//                 ),
//                 onPressed: () {
//                   final totalAddOnPrice = _calculateAddOnPrice();
//                   final totalPrice = selectedSize.price + totalAddOnPrice;
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                         content:
//                             Text('Added to cart for $totalPrice Dinar(s)!')),
//                   );
//                 },
//                 child: const Text('Add to Cart'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSizeOptions(ProductSize? sizes) {
//     if (sizes == null) return const Text('No sizes available');

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _buildSizeOption('Small', sizes.small),
//         _buildSizeOption('Medium', sizes.medium),
//         _buildSizeOption('Large', sizes.large),
//       ],
//     );
//   }

//   Widget _buildSizeOption(String label, SizeInfo? sizeInfo) {
//     if (sizeInfo == null) return Container();

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedSize = sizeInfo; // Update selected size
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color:
//               selectedSize == sizeInfo ? Colors.green.shade100 : Colors.white,
//           border: Border.all(color: Colors.green),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Column(
//           children: [
//             Text(
//               label,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text('${sizeInfo.price}D'),
//             Text('${sizeInfo.calories ?? 0} cal'),
//           ],
//         ),
//       ),
//     );
//   }

//   int _calculateAddOnPrice() {
//     // Add-on prices
//     const addOnPrices = [2, 2, 3];
//     int total = 0;
//     for (int i = 0; i < selectedAddOns.length; i++) {
//       if (selectedAddOns[i]) {
//         total += addOnPrices[i];
//       }
//     }
//     return total;
//   }
// }

import 'package:fit_bowl_2/data/modeles/supplement_model.dart';
import 'package:fit_bowl_2/presentation/controllers/supplement_contoller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:get/get.dart';

class SaladeScreen extends StatefulWidget {
  final Product product;

  const SaladeScreen({super.key, required this.product});

  @override
  _SaladeScreenState createState() => _SaladeScreenState();
}

class _SaladeScreenState extends State<SaladeScreen> {
  late SizeInfo selectedSize;
  final List<bool> selectedAddOns = [false, false, false];
  final Set<String> selectedSupplements = {}; // Track selected supplements
  SupplementModel? selectedSupplement; // Define selected supplement
  int selectedQuantity = 1;
  late final SupplementController _controller;

  @override
  void initState() {
    super.initState();
    selectedSize =
        widget.product.sizes?.small ?? SizeInfo(price: 0, calories: 0);

    Get.put(SupplementController());
    _controller = Get.find();
    // Fetch all supplements by their ids from the suppId list
    if (widget.product.suppId != null) {
      for (var supplement in widget.product.suppId!) {
        _controller.getSupplementById(supplement.id); // Fetch supplement by id
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F6ED),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info Section
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(product.image),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.name ?? "No name available",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Taille: ${selectedSize == widget.product.sizes?.small ? 'S' : selectedSize == widget.product.sizes?.medium ? 'M' : 'L'}        '
                      'calories: ${selectedSize.calories ?? 0}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Ingrédients Section
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingrédients',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description != null
                          ? product.description!
                              .split('•')
                              .map((item) => '• ${item.trim()}')
                              .join('\n')
                          : "No ingredients available",
                      style: const TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sizes Section
            Center(
              child: const Text(
                'Sizes:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            _buildSizeOptions(product.sizes),
            const SizedBox(height: 60),

            // Add-Ons Section
            Center(
              child: const Text(
                'Souhaitez-vous des suppléments :',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Supplement options
            ...product.suppId?.map(
                  (supplement) => _buildAddOnOption(
                    product.suppId!.indexOf(supplement),
                    supplement.name,
                    supplement.price,
                    supplement.calories ?? 0,
                  ),
                ) ??
                [],

            const SizedBox(height: 30),

            // Quantity Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Combien de bol :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (selectedQuantity > 1) selectedQuantity--;
                        });
                      },
                    ),
                    Text('$selectedQuantity', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          selectedQuantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 100),

            // Add to Cart Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  final totalAddOnPrice = _calculateAddOnPrice();
                  final totalPrice = selectedSize.price + totalAddOnPrice;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Added to cart for $totalPrice Dinar(s)!')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOptions(ProductSize? sizes) {
    if (sizes == null) return const Text('No sizes available');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSizeOption('Small', sizes.small),
        _buildSizeOption('Medium', sizes.medium),
        _buildSizeOption('Large', sizes.large),
      ],
    );
  }

  Widget _buildSizeOption(String label, SizeInfo? sizeInfo) {
    if (sizeInfo == null) return Container();

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = sizeInfo; // Update selected size
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              selectedSize == sizeInfo ? Colors.green.shade100 : Colors.white,
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('${sizeInfo.price}D'),
            Text('${sizeInfo.calories ?? 0} cal'),
          ],
        ),
      ),
    );
  }

  // Add-on Options Section
  Widget _buildAddOnOption(
      int index, String title, double price, double calories) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddOns[index] = !selectedAddOns[index];
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selectedAddOns[index] ? Colors.green.shade100 : Colors.white,
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('+${price}D'),
                    // ignore: unnecessary_brace_in_string_interps
                    Text('${calories} cal'),
                  ],
                ),
              ),
              Icon(
                selectedAddOns[index]
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: selectedAddOns[index] ? Colors.green : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateAddOnPrice() {
    // Add-on prices
    const addOnPrices = [2, 2, 3];
    int total = 0;
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        total += addOnPrices[i];
      }
    }
    return total;
  }
}
