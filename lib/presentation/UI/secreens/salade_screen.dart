import 'package:fit_bowl_2/domain/usecases/salesusecase/create_sale_usecase.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/model_view_screen.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/sale_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/supplement_contoller.dart';
import 'package:flutter/material.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/presentation/controllers/cart_controller.dart';

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
  int selectedQuantity = 1;
  late final SupplementController _supplementController;
  late final SalesController _salesController;
  late final AuthenticationController _authenticationController;
  late final CartController _cartController;
  String? currentUserId; // Make sure this is initialized
  // final GlobalKey modelViewerKey = GlobalKey(); // Fixed Key

  // void startARSession() {

  //   (modelViewerKey.currentContext?.findRenderObject() as dynamic)
  //       ?.onArButtonPressed();
  // }

  // void showModelDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(16),
  //           width: MediaQuery.of(context).size.width * 0.8, // Adjust width
  //           height: 450, // Adjust height
  //           child: Column(
  //             children: [
  //               // Close Button
  //               Align(
  //                 alignment: Alignment.topRight,
  //                 child: IconButton(
  //                   icon: Icon(Icons.close, color: Colors.red),
  //                   onPressed: () {
  //                     Navigator.of(context).pop(); // Close Dialog
  //                   },
  //                 ),
  //               ),

  //               // 3D Model Viewer
  //               Expanded(
  //                 child: ModelViewer(
  //                   key: modelViewerKey, // Assign key
  //                   arPlacement: ArPlacement.floor,
  //                   backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
  //                   src:
  //                       "https://modelviewer.dev/shared-assets/models/Astronaut.glb",
  //                   alt: 'A 3D model of an astronaut',
  //                   ar: true,
  //                   autoRotate: true,
  //                   disableZoom: false,
  //                 ),
  //               ),

  //               SizedBox(height: 10),

  //               // "View in AR" Button
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Colors.green,
  //                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(8)),
  //                 ),
  //                 onPressed: startARSession, // Start AR Mode
  //                 child: Text(
  //                   "View in AR",
  //                   style: TextStyle(fontSize: 16, color: Colors.white),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

//   @override
  @override
  void initState() {
    super.initState();
    selectedSize =
        widget.product.sizes?.small ?? SizeInfo(price: 0, calories: 0);

    _supplementController = Get.put(SupplementController());
    _salesController = Get.put(SalesController());
    _authenticationController = Get.find();
    _cartController = Get.put(CartController()); // Initialize CartController

    // Ensure user authentication data is ready
    currentUserId = _authenticationController.currentUser.id;

    // Fetch supplements if any
    if (widget.product.suppId != null) {
      for (var supplement in widget.product.suppId!) {
        _supplementController.getSupplementById(supplement.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    // Calculate the total price
    final totalAddOnPrice = _calculateAddOnPrice();
    final totalPrice = selectedSize.price * selectedQuantity + totalAddOnPrice;

    // Calculate total calories
    final totalCalories = _calculateTotalCalories();

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

            // Open 3D Model Viewer Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ModelViewerScreen(modelUrl: product.model3d),
                    ),
                  );
                },
                child: Text(
                  'Show 3D Model',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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
                const Text(
                  'Combien de bol :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (selectedQuantity > 1) selectedQuantity--;
                        });
                      },
                    ),
                    Text('$selectedQuantity',
                        style: const TextStyle(fontSize: 18)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
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
            const SizedBox(height: 50),

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
                onPressed: () async {
                  // Ensure currentUserId is not null before calling createSale
                  if (currentUserId != null) {
                    try {
                      final params = CreateSaleParams(
                        productId: widget.product.id, // Use the product ID
                        userId: currentUserId!, // Use the current user ID
                        quantity: selectedQuantity, // The selected quantity
                        supplements: selectedSupplements
                            .toList(), // List of selected supplements
                        totalprice: totalPrice, // Total price of the sale
                        totalCalories:
                            totalCalories, // Total calories of the sale
                      );

                      // Create the sale (without expecting a result)
                      final sale = await _salesController.createSale(params);

                      print(sale!.id);
                      final addToCartResult = await _cartController
                          .addSaleToCart(currentUserId!, sale.id);

                      // Provide feedback to the user
                      if (addToCartResult) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Added to cart for $totalPrice Dinar(s)!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to add to cart')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to create sale')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Please log in to proceed with the purchase!')),
                    );
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                child: Text(
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 246, 255, 246),
                    ),
                    'Add to Cart: $totalPrice D | $totalCalories cal'),
              ),
            ),
            const SizedBox(height: 20),
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
          if (selectedAddOns[index]) {
            selectedSupplements.add(title);
          } else {
            selectedSupplements.remove(title);
          }
        });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  selectedAddOns[index] ? Colors.green.shade100 : Colors.white,
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Prix: $price D'),
                Text('Calories: $calories'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateAddOnPrice() {
    double total = 0;
    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        total += widget.product.suppId?[i].price ?? 0;
      }
    }
    return total * selectedQuantity;
  }

  // Calculate total calories from selected size and supplements
  double _calculateTotalCalories() {
    double totalCalories = (selectedSize.calories ?? 0).toDouble();

    for (int i = 0; i < selectedAddOns.length; i++) {
      if (selectedAddOns[i]) {
        totalCalories += (widget.product.suppId?[i].calories ?? 0).toDouble();
      }
    }

    return totalCalories * selectedQuantity;
  }
}
